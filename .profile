
# ------------------------------------------
# Misc. Environment
# ------------------------------------------

export LC_CTYPE=en_US.UTF-8
export LANG=en_US.UTF-8
export JAVA_HOME="/System/Library/Frameworks/JavaVM.framework/Versions/1.6.0/Home"
export ANT_HOME=/usr/share/ant
export GRADLE_HOME=/opt/local/share/java/gradle
export GRAILS_HOME="/opt/local/share/java/grails"
export CATALINA_OPTS="-server -Xmx256m"
export CFLAGS="-O2 -pipe"
export CXXFLAGS=${CFLAGS}
export MAKEOPTS="-j9"
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
# export CC="$(xcode-select --print-path)/usr/bin/cpp"

export PYRAMID_DEBUGTOOLBAR=0

# for https://github.com/sickill/stderred
# export DYLD_INSERT_LIBRARIES=${HOME}/project/stderred/lib/stderred.dylib 
# export DYLD_FORCE_FLAT_NAMESPACE=1

export MAVEN_OPTS="-Xmx1028m -XX:MaxPermSize=256m"
PERL_VERSION=$(file `which perl`|grep 'symbolic link'|awk '{print $5}'|tr -d "\`\'")

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
export PATH=$PATH:"${ANDROID_HOME}/platform-tools"
export PATH=$PATH:"${ANDROID_HOME}/tools"
export PATH=$PATH:"/opt/local/libexec/perl$PERL_VERSION"

# ------------------------------------------
# convenient ssh handling
# ------------------------------------------

SSHAGENT=$(which ssh-agent)
SSHADD=$(which ssh-add)
SSHAGENTARGS="-s -t 21600" # add with lifetime 6h
SSHADD_ARGS="-t 21600 $HOME/.ssh/id_rsa" # add with lifetime 6h
function start_agent {
     echo "Initialising new SSH agent..."
     # eval `${SSHAGENT} ${SSHAGENTARGS}`
     ${SSHAGENT} ${SSHAGENTARGS}
     echo "...success"
     ${SSHADD} ${SSHADD_ARGS}
}
function check_agent {
    ps -ef | grep "${SSHAGENT} ${SSHAGENTARGS}$" > /dev/null || {
         start_agent;
    }
}
# If not running interactively, don't do anything
[ -z "$PS1" ] && return


# ------------------------------------------
# Aliases
# ------------------------------------------
alias ssh='check_agent; ssh'
alias ll='ls -l'
alias diff='diff -u'
alias la='ls -lAh'
alias l='ls -CF'
if [[ "$(uname)" == *"Darwin"* ]]; then
    alias free='top -l 1 | grep Phys'
    alias top='top -o cpu'
fi
alias grep="grep --exclude='all-wcprops' --exclude='*.tmp' --exclude='entries' --exclude='*.svn-base' --exclude='*.svn*' "
alias meld='/Applications/DiffMerge.app/Contents/MacOS/diffmerge.sh'
alias gvim='/Applications/MacVim.app/Contents/MacOS/Vim -g'
alias q="$(which qlmanage) -p "

# general functions
function git_diff() {
    git diff --no-ext-diff -w "$@" | vim -R -
}

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
# https://trac.macports.org/wiki/howto/bash-completion
if [ -f /opt/local/etc/profile.d/bash_completion.sh ]; then
    . /opt/local/etc/profile.d/bash_completion.sh
fi

GIT_COMPLETION_DIR="/opt/local/share/git-core/contrib/completion"
[ -f "${GIT_COMPLETION_DIR}/git-completion.bash" ] \
    && . "${GIT_COMPLETION_DIR}/git-completion.bash"
[ -f "${GIT_COMPLETION_DIR}/git-prompt.sh" ] \
    && . "${GIT_COMPLETION_DIR}/git-prompt.sh"


[ `uname -a|grep Linux|wc -l` -gt 0 ] && is_linux=true || is_linux=false 

# ------------------------------------------
# Colors
# install ``sudo port -v install coreutils``
# ------------------------------------------

if [ "$color_prompt" = yes ]; then
    GNU_LS="/opt/local/libexec/gnubin/ls"
    if [ "$TERM" != "dumb" ] && [ -x $GNU_LS ]; then
        alias ls='/opt/local/libexec/gnubin/ls --color=auto'
    fi

    export LS_OPTIONS='--color=auto'
    GNU_DIRCOLORS="/opt/local/libexec/gnubin/dircolors"
    if [ "$TERM" != "dumb" ] && [ -x $GNU_DIRCOLORS ]; then
        eval $($GNU_DIRCOLORS $HOME/.dir_colors)

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
    if $is_linux; then
        alias ls='ls $LS_OPTIONS'
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
    HOSTNAME_SHORT=$(hostname|sed -e 's/^\([^\.]\{0,\}\)\..*$/\1/')

    function git_dirty()
    {
        exit 0
        [[ "$(git status 2> /dev/null)" =~ "working directory clean" ]] || \
            echo -e " $ESC[${DULL};${FG_RED}m⚡$ESC[m"
    }

    PS1="${CYAN}\$([ \"root\" == \"$USER\" ] && printf \"${BRIGHT_RED}\")${USER} ${BRIGHT_BLUE}${HOSTNAME_SHORT}${WHITE} \w ${GREEN}\$([ \"function\" == \"`type -t __git_ps1`\" ] && __git_ps1 "%s"; git_dirty) ${NORMAL}\$ ${RESET}"
    export CLICOLOR=1
fi

if $is_linux; then
    if [ "$BASH" ]; then
      if [ -f ~/.bashrc ]; then
        . ~/.bashrc
      fi
    fi

    mesg n 
fi
