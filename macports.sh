#!/bin/bash
set -e
port -v install coreutils bash bash-completion apg tree grep rsync
port -v install python27
port -v install vim +python27
port -v install git-core +bash_completion +credential_osxkeychain +svn
port -v install nmap ngrep htop vnstat iftop libyaml ImageMagick
port -v install apple-gcc42 cmake gnupg
port -v install ffmpeg +nonfree 
port -v install mplayer +smb +mencoder_extras +a52 +aa +noappleremote +osd

echo "sudo vim /etc/shells"
echo "chsh -s /opt/local/bin/bash $USER"
