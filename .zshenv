# vim: foldmethod=marker
export KEYTIMEOUT=1
export CLICOLOR=1
export TERM=xterm-256color
export LANG=en_US.UTF-8

alias cls='clear'
alias sudovi='sudo command vi -u NONE'

# {{{ functions
function brew() {
  if [[ $1 =~ '(re|un)?install?' || $1 == 'remove' ]] ; then
    command brew $@ && command brew bundle dump --global -f && command brew cleanup
  else
    command brew $@
  fi
}

function is_git_repo() {
  [ -d .git ] || git rev-parse --git-dir > /dev/null 2>&1
  echo "$(($? == 0))"
}

function bitbucket_ssh_to_https() {
  # ssh://git@git.corp.com:8888/projectname/reponame.git -> https://git.corp.com/projects/projectname/repos/reponame/browse
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

  (cd $HOME/.config/yarn/global/
    rm -rf yarn.lock yarn-error.log
    mv package.json old_package.json
    cat old_package.json | jq '.dependencies
        | to_entries
        | map(.+{"value":"latest"})
        | from_entries
        | {"license":"MIT", "dependencies":.}' > package.json
    rm old_package.json
    NODE_ENV=production yarn install)

  (cd $HOME/.vim/bundle/tern_for_vim && npm i -s --no-package-lock)

  git -C $HOME submodule update --remote
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
