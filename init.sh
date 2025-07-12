#! /bin/bash
# shellcheck disable=SC2012,SC2086
set -xe

CWD="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

configs=$(ls -1 config)
for config in ${configs}; do
  if [ $config == "mcphub" ]; then
    mkdir -p "$HOME/.config/mcphub"
    jq --arg key "$BRAVE_API_KEY" \
      '.mcpServers["brave-search"].env.BRAVE_API_KEY = $key' \
      "$HOME/dotfiles/config/mcphub/servers-no-cred.json" >"$HOME/.config/mcphub/servers.json"
  else
    rm -rf "${HOME}/.config/${config}"
    ln -s "${CWD}/config/${config}" "$HOME/.config"
  fi
done


#later when the .config/mcphub/servers.json is updated, incron will update the file in dotfiles

rm -rf "${HOME}/{.tmux.conf,.tmuxline.conf,.zshrc_shared,.gitconfig}"
ln -s "${CWD}/{.tmux.conf,.tmuxline.conf,.zshrc_shared,.gitconfig}" "$HOME"

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
  [ ! -f $HOME/.zshrc ] && echo "source $HOME/.zshrc_shared" >$HOME/.zshrc
fi
