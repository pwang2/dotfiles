#! /bin/bash
# shellcheck disable=SC2086

set -xe

CWD="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

rm -rf ${HOME}/.config/{alacritty,nvim}
rm -rf ${HOME}/{.tmux.conf,.tmuxline.conf,.zshrc_shared}

ln -s ${CWD}/.config/{alacritty,nvim} $HOME/.config
ln -s ${CWD}/{.tmux.conf,.tmuxline.conf,.zshrc_shared} $HOME

if uname | grep -q Darwin; then
  rm -rf "$HOME/.hammerspoon"
  ln -s "${CWD}/.hammerspoon" "$HOME"
fi
