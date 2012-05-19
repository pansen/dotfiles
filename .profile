
# ------------------------------------------
# Misc. Environment
# ------------------------------------------

export JAVA_HOME="/System/Library/Frameworks/JavaVM.framework/Versions/1.6.0/Home"
export ANT_HOME=/usr/share/ant
export GRAILS_HOME="/opt/local/share/java/grails"
export CATALINA_OPTS="-server -Xmx256m"
export RABBITMQ_NODENAME='svz-pcn-205'
export CFLAGS="-O2 -pipe"
export CXXFLAGS=${CFLAGS}
export MAKEOPTS="-j2"
export PYTHONSTARTUP=~/.pythonstartup
export M2_REPO=~/.m2
export ANDROID_HOME=~/Library/android-sdk-macosx
export PIP_DOWNLOAD_CACHE=$HOME/Library/Caches/pip-downloads

# history management
export HISTCONTROL=ignoredups
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
export HISTSIZE=10000

export EDITOR=vim
export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'
export C_INCLUDE_PATH=/opt/local/include
export CXX_INCLUDE_PATH=/opt/local/include
export CPATH=/opt/local/include
export LIBRARY_PATH=/opt/local/lib
export DYLD_FALLBACK_LIBRARY_PATH=/opt/local/include:/opt/local/lib
export CPPFLAGS="-I/opt/local/include"

# for https://github.com/sickill/stderred
# export DYLD_INSERT_LIBRARIES=${HOME}/project/stderred/lib/stderred.dylib 
# export DYLD_FORCE_FLAT_NAMESPACE=1

export MAVEN_OPTS="-Xmx2048m -XX:MaxPermSize=512m"


# ------------------------------------------
# PATH 
# ------------------------------------------

export PATH="~/bin:$PATH"
export PATH="/opt/local/bin:$PATH"
export PATH="/opt/local/sbin:$PATH"
export PATH="$PATH:/System/Library/Frameworks/JavaVM.framework/Versions/1.6.0/Home/bin"
export PATH=$PATH:~/Library/android-sdk-macosx/tools
export PATH=$PATH:~/.gem/ruby/1.8/bin
export PATH=$PATH:"/Applications/VMware Fusion.app/Contents/Library"


# ------------------------------------------
# convenient ssh handling
# ------------------------------------------

SSHAGENT=$(which ssh-agent)
SSHADD=$(which ssh-add)
SSHAGENTARGS="-s -t 21600" # add with lifetime 6h
function start_agent {
     echo "Initialising new SSH agent..."
     ${SSHAGENT} ${SSHAGENTARGS}
     echo "...success"
     ${SSHADD};
}
function check_agent {
    ps -ef | grep "${SSHAGENT} ${SSHAGENTARGS}$" > /dev/null || {
         start_agent;
    }
}
SSH_ENV="$HOME/.ssh/environment"
alias ssh='check_agent; ssh'

# If not running interactively, don't do anything
[ -z "$PS1" ] && return


# ------------------------------------------
# Aliases
# ------------------------------------------

alias ll='ls -l'
alias la='ls -lAh'
alias l='ls -CF'
alias free='top -l 1 | grep Phys'
alias top='top -o cpu'
alias grep="grep --exclude='all-wcprops' --exclude='*.tmp' --exclude='entries' --exclude='*.svn-base' --exclude='*.svn*' "
alias meld='/Applications/DiffMerge.app/Contents/MacOS/diffmerge.sh'


# ------------------------------------------
# Terminal
# ------------------------------------------

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# sudo port -v install lesspipe
[ -x /opt/local/bin/lesspipe.sh ] && eval "$(lesspipe.sh)"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
    xterm-256color) color_prompt=yes;;
esac


# ------------------------------------------
# Completion
# ------------------------------------------

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
if [ -f /opt/local/etc/bash_completion ]; then
    . /opt/local/etc/bash_completion
fi
[ -f /opt/local/share/doc/git-core/contrib/completion/git-completion.bash ] \
    && . /opt/local/share/doc/git-core/contrib/completion/git-completion.bash


# ------------------------------------------
# Colors
# ------------------------------------------

if [ "$color_prompt" = yes ]; then
    GNU_LS="/opt/local/libexec/gnubin/ls"
    if [ "$TERM" != "dumb" ] && [ -x $GNU_LS ]; then
        alias ls='/opt/local/libexec/gnubin/ls --color=auto'
    fi

    GNU_DIRCOLORS="/opt/local/libexec/gnubin/dircolors"
    if [ "$TERM" != "dumb" ] && [ -x $GNU_DIRCOLORS ]; then
        eval $($GNU_DIRCOLORS $HOME/.dir_colors)

        export LS_OPTIONS='--color=auto'
        export CLICOLOR='Yes'

        #alias dir='ls --color=auto --format=vertical'
        #alias vdir='ls --color=auto --format=long'

        #alias grep='grep --color=auto'
        #alias fgrep='fgrep --color=auto'
        #alias egrep='egrep --color=auto'
    else
        # set dircolors for osx native fileutils
        # http://www.napolitopia.com/2010/03/lscolors-in-osx-snow-leopard-for-dummies/
        export LSCOLORS='gxgxfxfxcxdxdxhbadbxbx'
        alias ls='ls -G'
    fi


    DULL=0
    BRIGHT=1

    FG_BLACK=30
    FG_RED=31
    FG_GREEN=32
    FG_YELLOW=33
    FG_BLUE=34
    FG_VIOLET=35
    FG_CYAN=36
    FG_WHITE=37

    FG_NULL=00

    BG_BLACK=40
    BG_RED=41
    BG_GREEN=42
    BG_YELLOW=43
    BG_BLUE=44
    BG_VIOLET=45
    BG_CYAN=46
    BG_WHITE=47

    BG_NULL=00

    ##
    # ANSI Escape Commands
    ##
    ESC="\033"
    NORMAL="\[$ESC[m\]"
    RESET="\[$ESC[${DULL};${FG_WHITE};${BG_NULL}m\]"

    ##
    # Shortcuts for Colored Text ( Bright and FG Only )
    ##

    # DULL TEXT

    BLACK="\[$ESC[${DULL};${FG_BLACK}m\]"
    RED="\[$ESC[${DULL};${FG_RED}m\]"
    GREEN="\[$ESC[${DULL};${FG_GREEN}m\]"
    YELLOW="\[$ESC[${DULL};${FG_YELLOW}m\]"
    BLUE="\[$ESC[${DULL};${FG_BLUE}m\]"
    VIOLET="\[$ESC[${DULL};${FG_VIOLET}m\]"
    CYAN="\[$ESC[${DULL};${FG_CYAN}m\]"
    WHITE="\[$ESC[${DULL};${FG_WHITE}m\]"

    # BRIGHT TEXT
    BRIGHT_BLACK="\[$ESC[${BRIGHT};${FG_BLACK}m\]"
    BRIGHT_RED="\[$ESC[${BRIGHT};${FG_RED}m\]"
    BRIGHT_GREEN="\[$ESC[${BRIGHT};${FG_GREEN}m\]"
    BRIGHT_YELLOW="\[$ESC[${BRIGHT};${FG_YELLOW}m\]"
    BRIGHT_BLUE="\[$ESC[${BRIGHT};${FG_BLUE}m\]"
    BRIGHT_VIOLET="\[$ESC[${BRIGHT};${FG_VIOLET}m\]"
    BRIGHT_CYAN="\[$ESC[${BRIGHT};${FG_CYAN}m\]"
    BRIGHT_WHITE="\[$ESC[${BRIGHT};${FG_WHITE}m\]"

    # REV TEXT as an example
    REV_CYAN="\[$ESC[${DULL};${BG_WHITE};${BG_CYAN}m\]"
    REV_RED="\[$ESC[${DULL};${FG_YELLOW}; ${BG_RED}m\]"

    PS1="${CYAN}${USER} ${BRIGHT_BLUE}${HOSTNAME}${WHITE} \w ${GREEN}\$([ \"function\" == \"`type -t __git_ps1`\" ] && __git_ps1 "%s") ${NORMAL}\$ ${RESET}"
    export CLICOLOR=1
fi
