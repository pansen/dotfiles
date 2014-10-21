if [ "Darwin"=="$(uname)" ]; then
    [ -r ~/.profile ] && source ~/.profile
fi

[ -r ~/.bashrc ] && source ~/.bashrc
