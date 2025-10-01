#! /bin/bash
# shellcheck disable=SC2012,SC2086
set -xe

CWD="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

configs=$(ls -1 config)
for config in ${configs}; do
  rm -rf "${HOME}/.config/${config}"
  ln -s "${CWD}/config/${config}" "$HOME/.config/${config}"
done

FILES=(.tmux.conf .tmuxline.conf .zshrc_shared .gitconfig)

for file in "${FILES[@]}"; do
  rm -rf "$HOME/$file"
  ln -s "$CWD/$file" "$HOME/$file"
done

if uname | grep -q Darwin; then
  rm -rf "$HOME/hammerspoon"
  ln -s "${CWD}/hammerspoon" "$HOME"
fi

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  ZPLUGINS=$HOME/.oh-my-zsh/custom/plugins
  [ ! -d $ZPLUGINS/zsh-autosuggestions ] && git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git $ZPLUGINS/zsh-autosuggestions
  [ ! -d $ZPLUGINS/zsh-syntax-highlighting ] && git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git $ZPLUGINS/zsh-syntax-highlighting
  [ ! -d $ZPLUGINS/zsh-vi-mode ] && git clone --depth=1 https://github.com/jeffreytse/zsh-vi-mode $ZPLUGINS/zsh-vi-mode
  [ ! -d $ZPLUGINS/evalcache ] && git clone --depth=1 https://github.com/mroth/evalcache $ZPLUGINS/evalcache
  [ ! -d  $ZPLUGINS/zsh-github-copilot ] && git clone --depth=1 https://github.com/loiccoyle/zsh-github-copilot ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-github-copilot
  [ ! -f $HOME/.zshrc ] && echo "source $HOME/.zshrc_shared" >$HOME/.zshrc
fi


BREW_PREFIX=$([[ "$(uname -s)" == darwin* ]] && echo "/usr/local" || echo "/home/linuxbrew/.linuxbrew")
# if no brew install it 
if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$($BREW_PREFIX/bin/brew shellenv)"

  brew install uv fnm
fi

echo "run sudo apt-get install build-essential unzip gcc"
