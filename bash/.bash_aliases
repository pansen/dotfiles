# alias ssh='check_agent; ssh'
alias ll='ls -l'
alias diff='diff -u'
alias la='ls -lAh'
alias l='ls -CF'
alias grep='grep --color=auto'
alias meld='/Applications/DiffMerge.app/Contents/MacOS/diffmerge.sh'
alias gvim='/Applications/MacVim.app/Contents/MacOS/Vim -g'
alias q="$(which qlmanage) -p "
alias git-activity='git for-each-ref --sort=-committerdate refs/heads/|head -n28'


# http://thelucid.com/2012/01/04/naming-your-terminal-tabs-in-osx-lion/
function tabname {
  printf "\e]1;$1\a"
}
