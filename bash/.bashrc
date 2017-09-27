# history management
export HISTCONTROL=ignoredups
export HISTTIMEFORMAT="%d/%m/%y %T "

function timer_start {
  timer=${timer:-$SECONDS}
}
function timer_stop {
  timer_show=$(($SECONDS - $timer))
  unset timer
}
trap 'timer_start' DEBUG

if [ "$PROMPT_COMMAND" == "" ]; then
  PROMPT_COMMAND="timer_stop"
else
  PROMPT_COMMAND="$PROMPT_COMMAND; timer_stop"
fi

PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
export HISTSIZE=100000

# If not running interactively, don't do anything
[ -z "$PS1" ] && return
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac


# ------------------------------------------
# convenient ssh handling
# ------------------------------------------
# https://wiki.archlinux.org/index.php/GnuPG#gpg-agent
# http://www.swissunixsupport.com/mactips
#
# also install GPGTools for mac to get this net ``pinentry-mac`` application:
# https://github.com/GPGTools/pinentry-mac
gpg_envfile="$HOME/.gnupg/gpg-agent.env"
GPG_AGENT_OPTIONS=" --daemon \
    --enable-ssh-support \
    --default-cache-ttl-ssh 7200 \
    --max-cache-ttl-ssh 14400 \
    "
# killall gpg-agent; rm -f ~/.gnupg/S.gpg-agent ~/.gpg-agent-info ~/.gnupg/gpg-agent.env
if [[ -e "$gpg_envfile" ]] && kill -0 $(grep GPG_AGENT_INFO "$gpg_envfile" | cut -d: -f 2) 2>/dev/null; then
    echo "use existing $gpg_envfile"
    eval "$(cat "$gpg_envfile")"
else
    echo "start new process with <$GPG_AGENT_OPTIONS> ..."
    eval "$(gpg-agent $GPG_AGENT_OPTIONS)"
fi

# TODO: for some reason the terminal will not find that socket, if defined as `/Users/andi/.gnupg/S.gpg-agent:68389:1`
# to solve it, we cut off the last part
GPG_AGENT_INFO=`echo $GPG_AGENT_INFO | sed -E 's/:.*$//g'`
export GPG_AGENT_INFO  # the env file does not contain the export statement
export SSH_AUTH_SOCK   # enable gpg-agent for ssh
export GET_TTY=`tty`
# [ $(ps axu|grep 'gpg-agent --daemon'|grep -v grep|wc -l) -eq 0 ] && eval $(gpg-agent --daemon $GPG_AGENT_OPTIONS)


# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# ------------------------------------------
# Aliases
# ------------------------------------------
if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

# general functions
git_diff()
{
    git diff --no-ext-diff -w "$@" | vim -R -
}

# ------------------------------------------
# Terminal
# ------------------------------------------

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

# the one from homebrew: `brew install bash-completion2`
if [ -f /usr/local/share/bash-completion/bash_completion ]; then
    . /usr/local/share/bash-completion/bash_completion
fi

# http://superuser.com/a/32299
GIT_COMPLETION_DIR="$PORTS_PREFIX/etc/bash_completion.d"
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
    GNU_LS="$PORTS_PREFIX/opt/coreutils/libexec/gnubin/ls"
    if [ "$TERM" != "dumb" ] && [ -x $GNU_LS ]; then
        alias ls='$PORTS_PREFIX/opt/coreutils/libexec/gnubin/ls --color=auto'
    fi

    export LS_OPTIONS='--color=auto'
    GNU_DIRCOLORS="$PORTS_PREFIX/opt/coreutils/libexec/gnubin/dircolors"
    if [ "$TERM" != "dumb" ] && [ -x $GNU_DIRCOLORS ]; then
        eval $($GNU_DIRCOLORS $HOME/.dir_colors)

        export CLICOLOR='Yes'
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

    # background
    BG_BLACK="\w\[\033[${DULL};${FG_NULL};${BG_BLACK}m\]"

    function git_branch()
    {
        [ \"function\" == \"`type -t __git_ps1`\" ] || return 0

        local BRANCH="$(__git_ps1 '%s')"
        [ "$BRANCH" == "" ] && printf " " && return 0

        if [[ "$(git status 2> /dev/null)" =~ "working directory clean" ]]; then
            # thanks to https://github.com/michaeldfallen/git-radar/blob/master/prompt.bash
            printf "\x01\033[1;32m\x02${BRANCH} \x01\033[0m\x02"
        else
            printf "\x01\033[1;33m\x02${BRANCH} \x01\033[0m\x02"
        fi
    }

    PS1="${CYAN}\$([ \"root\" == \"$USER\" ] && printf \"${BRIGHT_RED}\")${USER} ${BRIGHT_BLUE}${HOSTNAME_SHORT}${WHITE} \w \$(git_branch)\${timer_show} \$ "
    export CLICOLOR=1
fi
