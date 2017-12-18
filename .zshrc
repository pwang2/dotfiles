ZSH=$HOME/.oh-my-zsh
ZSH_CUSTOM="$HOME/.zsh_custom"
ZSH_THEME="robbyrussell"
ZSH_HIGHLIGHT_MAXLENGTH=16
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=blue"
plugins=(zsh-vim-mode docker yarn git tmux zsh-autosuggestions zsh-syntax-highlighting)

. $ZSH/oh-my-zsh.sh
. $HOME/.iterm2_shell_integration.zsh
. /usr/local/etc/profile.d/autojump.sh

export HOMEBREW_GITHUB_API_TOKEN="326cc9be987d5a30237b1ccc73b539d2a46ae7b1"
export PATH="/usr/local/opt/node@8/bin:$PATH"
