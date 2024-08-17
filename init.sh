cwd="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

rm -rf $HOME/.config/{alacritty,nvim}
rm -rf $HOME/.hammerspoon
rm -rf $HOME/.tmux.conf
rm -rf $HOME/.tmuxline.conf

ln -s ${cwd}/.config/{alacritty,nvim} $HOME/.config
ln -s ${cwd}/.hammerspoon $HOME
ln -s ${cwd}/{.tmux.conf,.tmuxline.conf} $HOME



