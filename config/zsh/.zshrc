#---------------------------
# History Configuration
#---------------------------
export HISTSIZE=50000
export SAVEHIST=10000
export HISTFILE=~/.zsh_history

setopt hist_ignore_all_dups  # don't save duplicate commands
setopt hist_ignore_space     # don't save commands that start with space
setopt inc_append_history    # append to history immediately

# history cleanup function
function smite() {
    setopt LOCAL_OPTIONS ERR_RETURN PIPE_FAIL

    local opts=( -I )
    if [[ $1 == '-a' ]]; then
        opts=()
    elif [[ -n $1 ]]; then
        print >&2 'usage: smite [-a]'
        return 1
    fi

    fc -l -n $opts 1 | \
        fzf --no-sort --tac --multi | \
        while IFS='' read -r command_to_delete; do
            printf 'Removing history entry "%s"\n' $command_to_delete
            local HISTORY_IGNORE="${(b)command_to_delete}"
            fc -W
            fc -p $HISTFILE $HISTSIZE $SAVEHIST
        done
}

#---------------------------
# Prompt Configuration
#---------------------------
setopt prompt_subst          # allow command substitution in prompt

autoload -Uz vcs_info                                   # load vcs info
precmd() { vcs_info }                                   # always load vcs
zstyle ':vcs_info:git*' formats '(%F{050}%b%F{153})%f ' # format $vcs_info_msg_0_

# git status function
function parse_git_dirty() {
  local git_status
  git_status=$(git status 2>/dev/null) || return

  local indicators=""

  # Check for various git states using zsh pattern matching
  [[ $git_status == *"Your branch is ahead of"* ]] && indicators+='%F{222}↑%f '
  [[ $git_status == *"Changes to be committed:"* ]] && indicators+='%F{222}+%f '
  [[ $git_status == *"Changes not staged for commit:"* ]] && indicators+='%F{222}!%f '
  [[ $git_status == *"Untracked files:"* ]] && indicators+='%F{222}?%f '

  echo -n $indicators
}

# set the prompt
PS1='%F{254}%n@%m%f %F{153}%(5~|%-1~/⋯/%3~|%4~) ${vcs_info_msg_0_}$(parse_git_dirty)%f$ '

#---------------------------
# Tools Configuration
#---------------------------

# mise
eval "$(/home/boris/.local/bin/mise activate zsh)"

# local binaries
export PATH=${PATH}:${HOME}/.local/bin

#---------------------------
# Plugins
#---------------------------
# auto-suggestions
source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

#---------------------------
# Aliases
#---------------------------
alias tf="terraform"
alias ts="tailscale"
