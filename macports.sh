#!/bin/bash
set -e
port -v install coreutils bash bash-completion apg tree grep rsync watch jq pv gpg-agent
port -v install python27
port -v install apg gpg-agent
port -v install py27-docutils
port -v install vim +python27
port -v install git +bash_completion +svn -credential_osxkeychain
port -v install the_silver_searcher
port -v install nmap ngrep htop vnstat iftop bmon libyaml ImageMagick
port -v install apple-gcc42 cmake gnupg
port -v install ffmpeg +nonfree 
port -v install mplayer +smb +mencoder_extras +a52 +aa +noappleremote +osd
port -v install testdisk
port -v install dos2unix 

echo "sudo vim /etc/shells"
echo "chsh -s /opt/local/bin/bash $USER"
