cwd="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

rm -rf $HOME/.config/{alacritty,nvim}
rm -rf $HOME/{.tmux.conf,.tmuxline.conf}

ln -s ${cwd}/.config/{alacritty,nvim} $HOME/.config
ln -s ${cwd}/{.tmux.conf,.tmuxline.conf} $HOME

uname | grep -q Darwin
if [ $? -eq 0 ]; then
  rm -rf $HOME/.hammerspoon
  ln -s ${cwd}/.hammerspoon $HOME
fi
