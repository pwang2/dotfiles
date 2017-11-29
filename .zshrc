export EDITOR=vim
export ZSH=$HOME/.oh-my-zsh
export HOMEBREW_GITHUB_API_TOKEN="326cc9be987d5a30237b1ccc73b539d2a46ae7b1"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=blue"

ZSH_THEME="robbyrussell"
ZSH_CUSTOM="$HOME/.zsh_custom"
ZSH_HIGHLIGHT_MAXLENGTH=16
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
plugins=(zsh-vim-mode docker yarn git tmux zsh-autosuggestions zsh-syntax-highlighting)

export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/gettext/bin:$PATH"
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
export MANPATH="/usr/local/opt/{coreutils,gnu-sed}/libexec/gnuman:$MANPATH"
#export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export JIRA_URL="https://jira.uptake.com"
. $ZSH/oh-my-zsh.sh
. $HOME/.iterm2_shell_integration.zsh
. /usr/local/etc/profile.d/autojump.sh
