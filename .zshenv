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

open_git_remote(){
  remote=${1:-origin}
  url=`git remote get-url ${remote}`
  #e.g.:
  #https://github.com/pwang2/hackathon-2017-11.git
  #ssh://git@git.uptake.com:7999/dp/adi-ui.git

  prot=`grep -oP '^[^/]*(?=(@|//))' <<< $url`
  host=`grep -oP '((?<=//)|(?<=@))[^:/]*' <<< $url`
  if [[ "$prot" == "https:" ]]; then
    open $url
  else
    open "https://$host"
  fi
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
alias gopen='open `git remote get-url origin`'
alias dps='docker ps -a --format="table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Image}}"'
alias jsonpp="python -c 'import sys, json; print json.dumps(json.load(sys.stdin), sort_keys=False, indent=2)'"
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
alias chrome-canary="/Applications/Google\ Chrome\ Canary.app/Contents/MacOS/Google\ Chrome\ Canary"

function routine() {
  upgrade_oh_my_zsh
  brew doctor || exit
  brew update
  brew upgrade
  brew cleanup
  brew cask cleanup
  brew bundle dump --global --force
  npm install -g npm@latest

  vi +PluginInstall +PluginUpdate +qall
  $HOME/.vim/bundle/YouCompleteMe/install.py --js-completer --tern-completer # --clang-completer
  $HOME/.tmux/plugins/tpm/scripts/update_plugin.sh --bug-here all

  (cd $HOME/.vim/bundle/tern_for_vim && npm i -s --no-package-lock)
  (cd $HOME/.config/yarn/global/ && yarn)

  git -C $HOME submodule foreach 'git pull'
  git -C $HOME add -A
  git -C $HOME commit -m "update $(date)"
  git -C $HOME push origin master
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
