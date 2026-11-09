# dotfiles

Dotfiles, automated. Clone anywhere and run `./install.sh`; it's safe to re-run.

## Setup

```sh
sudo apt install zsh git curl
git clone https://github.com/borisdvlpr/dotfiles.git
cd dotfiles && ./install.sh
```

Make sure zsh is the default shell: `chsh -s "$(command -v zsh)"`.

Don't run it as root. Install steps are skipped when already done, and clones are pulled.

## Structure

```text
dotfiles/
├── install.sh           # entry point: runs the steps in setup/
├── setup/               # one script per step, plus lib.sh (link helper)
├── config/              # app configs, one folder per tool
│   ├── ghostty/         #   manual: placeholder only
│   ├── mise/            #   automated
│   ├── zed/             #   automated
│   └── zsh/             #   stored, not deployed
├── scripts/             # custom scripts, run by path
└── raspberrypi/         # stored only, never touched by install.sh
```

## What install.sh does

Steps run in the order of `STEPS` in `install.sh` and stop at the first failure.

| Step | Installs | Configures |
|---|---|---|
| `mise` | mise, then the tools in `config/mise/global.toml` (fzf, go latest, java LTS via Corretto) | links `~/.config/mise/config.toml` |
| `zed` | Zed, via its official script | links `~/.config/zed/settings.json` |
| `zsh-plugins` | clones each repo in `PLUGINS` into `~/.zsh/plugins/` (zsh-autosuggestions); pulls on re-run | — |

Configs are symlinked to the repo, so edits made by an app show up in `git diff`. Anything already at a target is moved to `<target>.bak.<timestamp>`, never deleted. The same applies to a plugin folder that isn't a git clone.

## Configurations

| Repo file | Target | Status |
|---|---|---|
| `config/mise/global.toml` | `~/.config/mise/config.toml` | automated |
| `config/zed/settings.json` | `~/.config/zed/settings.json` | automated |
| `config/zsh/.zshrc` | `~/.zshrc` | manual for now |
| `config/ghostty/` | `~/.config/ghostty/` | manual, configured per machine |

To deploy `.zshrc` by hand, from the repo root: `mv ~/.zshrc ~/.zshrc.bak; ln -s "$PWD/config/zsh/.zshrc" ~/.zshrc`. Without it, `install.sh` reminds you that mise isn't activated in new shells.

## Maintenance

- **Upgrade tools:** `mise upgrade`. `latest` and `lts` are resolved once at install, so re-running doesn't upgrade them.
- **Add a tool:** add it to `config/mise/global.toml` and re-run.
- **Add a zsh plugin:** add `owner/repo` to `PLUGINS` in `setup/zsh-plugins.sh`.
