man() {
    env LESS_TERMCAP_mb=$'\E[01;31m' \
    LESS_TERMCAP_md=$'\E[01;38;5;74m' \
    LESS_TERMCAP_me=$'\E[0m' \
    LESS_TERMCAP_se=$'\E[0m' \
    LESS_TERMCAP_so=$'\E[38;5;246m' \
    LESS_TERMCAP_ue=$'\E[0m' \
    LESS_TERMCAP_us=$'\E[04;38;5;146m' \
    man "$@"
}

export KEYTIMEOUT=1
export CLICOLOR=1
export TERM=xterm-256color
export LANG=en_US.UTF-8

alias vi='mvim -v '
alias vim='mvim -v '
alias dm='docker-machine'
alias gcd='git checkout develop'
alias cls='clear'
alias dps='docker ps -a --format="table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Image}}"'
alias jsonpp="python -c 'import sys, json; print json.dumps(json.load(sys.stdin), sort_keys=False, indent=2)'"
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
alias chrome-canary="/Applications/Google\ Chrome\ Canary.app/Contents/MacOS/Google\ Chrome\ Canary"

function routine() {
    upgrade_oh_my_zsh
    brew doctor
    brew update
    brew upgrade
    brew cleanup
    brew cask cleanup
    brew bundle dump --global --force
    npm install -g npm@latest

    cd ~
    git submodule foreach 'git pull'
    git add -A
    git add -f Documents/ -A
    git commit -m "update $(date)"
    git push origin master
    echo 'update vi plugins'
    vi +PluginUpdate +qall
    $HOME/.vim/bundle/YouCompleteMe/install.py --tern-completer  --clang-completer
    $HOME/.tmux/plugins/tpm/scripts/update_plugin.sh --bug-here all
    cd ~/.vim/bundle/tern_for_vim
    npm i -s --no-package-lock
    cd /Users/pwang/.config/yarn/global/
    yarn
    cd ~
}

function add-github {
  appname=${1:-`grep -oP '(?<="name": ")(.*)(?=")' package.json`}
  curl -X POST https://api.github.com/user/repos -u 'pwang2' \
    -d "{\"name\":\"$appname\"}" \
    -H 'content-type:application/json' |
    jq -r .clone_url |
    pbcopy
}

function add-mine {
  appname=${1:-`grep -oP '(?<="name": ")(.*)(?=")' package.json`}
  curl -X POST \
    https://git.uptake.com/rest/api/1.0/projects/~pwang/repos \
    -u 'pwang' \
    -d "{\"name\":\"$appname\", \"public\": true}"  \
    -H 'content-type:application/json' \
    | jq -r '.links.clone[0].href' \
    | pbcopy
}
