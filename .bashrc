# history management
export HISTCONTROL=ignoredups
export HISTTIMEFORMAT="%d/%m/%y %T "
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
export HISTSIZE=100000

# ------------------------------------------
# convenient ssh handling
# ------------------------------------------

SSHAGENT=$(which ssh-agent)
SSHADD=$(which ssh-add)
SSHAGENTARGS="-s -t 21600" # add with lifetime 6h
SSHADD_ARGS="-t 21600 $HOME/.ssh/id_rsa" # add with lifetime 6h
start_agent()
{
     echo "Initialising new SSH agent..."
     # eval `${SSHAGENT} ${SSHAGENTARGS}`
     ${SSHAGENT} ${SSHAGENTARGS}
     echo "...success"
     ${SSHADD} ${SSHADD_ARGS}
}
check_agent()
{
    ps -ef | grep "${SSHAGENT} ${SSHAGENTARGS}$" > /dev/null || {
         start_agent;
    }
}
# If not running interactively, don't do anything
[ -z "$PS1" ] && return
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# ------------------------------------------
# Aliases
# ------------------------------------------
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
alias ssh='check_agent; ssh'
alias ll='ls -l'
alias diff='diff -u'
alias la='ls -lAh'
alias l='ls -CF'
if [ "$(uname)"==*"Darwin"* ]; then
    alias free='top -l 1 | grep Phys'
    alias top='top -o cpu'
fi
alias grep="grep --exclude='all-wcprops' --exclude='*.tmp' --exclude='entries' --exclude='*.svn-base' --exclude='*.svn*' "
alias meld='/Applications/DiffMerge.app/Contents/MacOS/diffmerge.sh'
alias gvim='/Applications/MacVim.app/Contents/MacOS/Vim -g'
alias q="$(which qlmanage) -p "
alias git-activity='git for-each-ref --sort=-committerdate refs/heads/|head -n28'

# general functions
git_diff()
{
    git diff --no-ext-diff -w "$@" | vim -R -
}

# ------------------------------------------
# Terminal
# ------------------------------------------

return
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# sudo port -v install lesspipe
[ -x $PORTS_PREFIX/bin/lesspipe.sh ] && eval "$(lesspipe.sh)"

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
if [ -f $PORTS_PREFIX/etc/bash_completion ]; then
    . $PORTS_PREFIX/etc/bash_completion
fi
# https://trac.macports.org/wiki/howto/bash-completion
if [ -f $PORTS_PREFIX/etc/profile.d/bash_completion.sh ]; then
    . $PORTS_PREFIX/etc/profile.d/bash_completion.sh
fi

GIT_COMPLETION_DIR="$PORTS_PREFIX/share/git-core/contrib/completion"
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
    GNU_LS="$PORTS_PREFIX/libexec/gnubin/ls"
    if [ "$TERM" != "dumb" ] && [ -x $GNU_LS ]; then
        alias ls='$PORTS_PREFIX/libexec/gnubin/ls --color=auto'
    fi

    export LS_OPTIONS='--color=auto'
    GNU_DIRCOLORS="$PORTS_PREFIX/libexec/gnubin/dircolors"
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
