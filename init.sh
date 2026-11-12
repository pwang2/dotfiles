#! /bin/bash
set -xe

CWD="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
BACKUP_SUFFIX=".bak.$(date +%Y%m%d%H%M%S)"

# link <src> <dest>: back up existing dest unless it already points at src
link() {
  local src=$1 dest=$2
  if [ -e "$dest" ] || [ -L "$dest" ]; then
    [ "$(readlink "$dest")" = "$src" ] && return 0
    mv "$dest" "${dest}${BACKUP_SUFFIX}"
  fi
  ln -sfn "$src" "$dest"
}

IS_WSL=false
grep -qi microsoft /proc/version 2>/dev/null && IS_WSL=true

mkdir -p "$HOME/.config"
for dir in "$CWD"/config/*; do
  link "$dir" "$HOME/.config/$(basename "$dir")"
done

FILES=(
  .tmux.conf
  .zshrc_shared
  .zshrc_brew
  .zshrc_comp_env
  .zshrc_functions
  .zshrc_tools
  .gitconfig
  .yamllint.yaml
)
$IS_WSL && FILES+=(.zshrc_wsl)

for file in "${FILES[@]}"; do
  link "$CWD/$file" "$HOME/$file"
done

if uname | grep -q Darwin; then
  link "$CWD/hammerspoon" "$HOME/hammerspoon"
fi

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

ZPLUGINS=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins
ZSH_PLUGIN_REPOS=(
  zsh-users/zsh-autosuggestions
  zsh-users/zsh-syntax-highlighting
  jeffreytse/zsh-vi-mode
  mroth/evalcache
)
for repo in "${ZSH_PLUGIN_REPOS[@]}"; do
  dest="$ZPLUGINS/${repo##*/}"
  [ -d "$dest" ] || git clone --depth=1 "https://github.com/$repo.git" "$dest"
done

# oh-my-zsh installer may write its own .zshrc; make sure ours is sourced
grep -qs '\.zshrc_shared' "$HOME/.zshrc" || echo "source $HOME/.zshrc_shared" >>"$HOME/.zshrc"

BREW_PREFIX=$([[ "$(uname -s)" == Darwin ]] && echo "/usr/local" || echo "/home/linuxbrew/.linuxbrew")
# if no brew install it
if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$("$BREW_PREFIX/bin/brew" shellenv)"

  brew install uv fnm zoxide
fi

echo "run sudo apt-get install build-essential unzip xdg-utils zsh tmux python3-venv"
