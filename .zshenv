# vim: foldmethod=marker
export KEYTIMEOUT=1
export CLICOLOR=1
export TERM=xterm-256color
export LANG=en_US.UTF-8
export EDITOR="mvim -v"

alias vi='mvim -v'
alias vim='mvim -v'
alias dm='docker-machine'
alias cls='clear'
alias sudovi='sudo command vi -u NONE'
alias dps='docker ps -a --format="table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Image}}"' alias dkill='docker ps  -qa | xargs docker rm -f'

# {{{ functions
function brew() {
  if [[ $1 == 'cask' ]] && [[ $2 == 'install' || $2 == 'remove' ]] \
    || [[ $1 == 'install' || $1 == 'remove' ]] ; then
    command brew $@ && command brew bundle dump --global -f && command brew cleanup && brew cask cleanup
  else
    command brew $@
  fi
}

function is_git_repo() {
  [ -d .git ] || git rev-parse --git-dir > /dev/null 2>&1
  echo "$(($? == 0))"
}

function bitbucket_ssh_to_https() {
  # ssh://git@git.uptake.com:7999/rep/xep-cli.git -> https://git.uptake.com/projects/REP/repos/xe-cli/browse
  if [[ "$1" =~ ssh:\/\/git@([^\/:]+)(:[[:digit:]]{4,})?\/([^\/]+)\/([^.]+)(\.git) ]]; then
    local branch=${2:=$(git rev-parse --abbrev-ref HEAD)}
    local url="https://$match[1]/projects/$match[3]/repos/$match[4]/browse"
    echo "take you to ${url}"
    open "$url?at=refs%2Fheads%2F$branch"
  else
    echo "invalid bitbucket url to match"
  fi
}

function gopen() {
  [[ $(is_git_repo) == 0 ]] && echo "not in a git repository"  && return
  git remote get-url origin > /dev/null 2>&1
  [[ $? != 0 ]] && echo "origin url not yet set" && return
  local origin=$(git remote get-url origin)
  [[ "$origin" =~ "^ssh://.*" ]] && bitbucket_ssh_to_https "$origin" "$1" && return
  open "$origin"
}

function man() {
  env LESS_TERMCAP_mb=$'\E[01;31m' \
    LESS_TERMCAP_md=$'\E[01;38;5;74m' \
    LESS_TERMCAP_me=$'\E[0m' \
    LESS_TERMCAP_se=$'\E[0m' \
    LESS_TERMCAP_so=$'\E[38;5;246m' \
    LESS_TERMCAP_ue=$'\E[0m' \
    LESS_TERMCAP_us=$'\E[04;38;5;146m' \
    man "$@"
}

function routine() {
  upgrade_oh_my_zsh
  brew prune
  brew doctor
  [[ $? != 0 ]] && echo "fix brew doctor output" && return
  brew update
  brew upgrade
  brew cask upgrade
  brew cleanup
  brew cask cleanup
  brew bundle install --global
  brew bundle dump --global --force

  vi +PluginInstall +PluginUpdate +qall
  $HOME/.vim/bundle/YouCompleteMe/install.py --js-completer --tern-completer # --clang-completer
  $HOME/.tmux/plugins/tpm/scripts/update_plugin.sh --bug-here all

  (cd $HOME/.config/yarn/global/ && NODE_ENV=production yarn upgrade && yarn outdated)
  (cd $HOME/.vim/bundle/tern_for_vim && npm i -s --no-package-lock)

  git -C $HOME submodule foreach 'git pull'
  git -C $HOME add -A
  git -C $HOME commit -m "update $(date)"
  git -C $HOME push origin master

  ln -sF $(yarn global dir)/node_modules  $HOME/node_modules
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
    https://git.uptake.com/rest/api/1.0/projects/~$(whoami)/repos \
    -u $(whoami) \
    -d "{\"name\":\"$appname\", \"public\": true}"  \
    -H 'content-type:application/json' \
    | jq -r '.links.clone[0].href' \
    | pbcopy
}
#}}}
