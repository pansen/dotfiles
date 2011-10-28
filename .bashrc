# If not running interactively, don't do anything
[ -z "$PS1" ] && return

[ -f /opt/local/share/doc/git-core/contrib/completion/git-completion.bash ] \
    && . /opt/local/share/doc/git-core/contrib/completion/git-completion.bash

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
if [ -f /opt/local/etc/bash_completion ]; then
    . /opt/local/etc/bash_completion
fi

# history management
export HISTCONTROL=erasedups
export HISTCONTROL=ignoreboth
export HISTCONTROL=ignoredups
export PROMPT_COMMAND='history -a'
export HISTSIZE=10000

export EDITOR=vim
export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'
export C_INCLUDE_PATH=/opt/local/include
export CXX_INCLUDE_PATH=/opt/local/include
export CPATH=/opt/local/include
export LIBRARY_PATH=/opt/local/lib
export DYLD_FALLBACK_LIBRARY_PATH=/opt/local/include:/opt/local/lib
export MAVEN_OPTS="-Xmx2048m -XX:MaxPermSize=512m"


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

PROMPT_COMMAND='export ERR=$?'

# PS1="${BRIGHT_CYAN}[${CYAN}\u$@\h${WHITE}:\w${BRIGHT_CYAN}]${NORMAL}\$ ${RESET}"
# PS1="${BRIGHT_CYAN}[${CYAN}${USER}@${HOSTNAME}${WHITE}: \w ${BRIGHT_CYAN}]${NORMAL}\$ ${RESET}"
# PS1="${BRIGHT_CYAN}[${CYAN}${USER}@\h${WHITE}: \w ${BRIGHT_CYAN}]${NORMAL}\$ ${RESET}"

# PS1="${BRIGHT_CYAN}[${CYAN}${USER}${WHITE} \w${BRIGHT_CYAN}]${NORMAL}\$ ${RESET}"
PS1="${BRIGHT_CYAN}[${CYAN}${USER}${WHITE} \w$(__git_ps1 "${GREEN} %s")${BRIGHT_CYAN}]${NORMAL}\$ ${RESET}"
# PS1='\h:\W$(__git_ps1 "(%s)") \u\$ '

# PS1="${BRIGHT_CYAN}[${CYAN}${USER}@\h${WHITE}: \w ${BRIGHT_CYAN} $(git remote -v 2>/dev/null|tail -n1|awk '{print $2}'|sed 's%\(^.*/\)\([^/]*   \)$%\2%g']${NORMAL}\$ ${RESET}"
