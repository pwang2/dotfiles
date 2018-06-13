ZSH=$HOME/.oh-my-zsh
ZSH_CUSTOM="$HOME/.zsh_custom"
ZSH_THEME="robbyrussell"
ZSH_HIGHLIGHT_MAXLENGTH=16
plugins=(zsh-vim-mode docker yarn git tmux zsh-autosuggestions zsh-syntax-highlighting)


export PATH="$HOME/.linuxbrew/bin:$PATH"
export TERM="xterm-256color"
export HOMEBREW_GITHUB_API_TOKEN="326cc9be987d5a30237b1ccc73b539d2a46ae7b1"
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=cyan"

[ -f $HOME/.fzf.zsh ] && . $HOME/.fzf.zsh
[ -f $(brew --prefix)/etc/profile.d/autojump.sh ] && . $(brew --prefix)/etc/profile.d/autojump.sh
[ -f $ZSH/oh-my-zsh.sh ] && . $ZSH/oh-my-zsh.sh
