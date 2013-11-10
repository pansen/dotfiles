#!/bin/bash
port -v install ffmpeg +nonfree 
port -v install mplayer +smb +mencoder_extras +a52 +aa +noappleremote +osd
port -v install git-core +bash_completion +credential_osxkeychain +svn
port -v install coreutils bash bash-completion nmap ngrep htop vnstat apple-gcc42 cmake apg
port -v install vim +python27

echo "sudo vim /etc/shells"
echo "chsh -s /opt/local/bin/bash andi"
