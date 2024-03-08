# zsh prompt
parse_git_dirty() {
  git_status="$(git status 2> /dev/null)"
  [[ "$git_status" =~ "Your branch is ahead of" ]] && echo -n "%F{222}↑%f "
  [[ "$git_status" =~ "Changes to be committed:" ]] && echo -n "%F{222}+%f "
  [[ "$git_status" =~ "Changes not staged for commit:" ]] && echo -n "%F{222}!%f "
  [[ "$git_status" =~ "Untracked files:" ]] && echo -n "%F{222}?%f "
}

setopt prompt_subst

autoload -Uz vcs_info                                   # enable vcs_info
precmd () { vcs_info }                                  # always load before displaying the prompt
zstyle ':vcs_info:git*' formats '(%F{050}%b%F{153})%f ' # format $vcs_info_msg_0_

PS1='%F{254}%n@%m%f %F{153}%(5~|%-1~/⋯/%3~|%4~) ${vcs_info_msg_0_}$(parse_git_dirty)%f$ '

# zsh history
export HISTSIZE=15000
export SAVEHIST=10000

setopt HIST_EXPIRE_DUPS_FIRST	# delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt HIST_IGNORE_DUPS			# ignore duplicated commands history list
setopt INC_APPEND_HISTORY		# add new lines to HISTFILE incrementally      	

# zsh plugins
source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# openjdk
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

# postgres@16
export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"
