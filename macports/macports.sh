#!/bin/bash
set -e
port -v install python27
port -v install python35
port -v install coreutils bash bash-completion stow
port -v install tree grep rsync watch jq pv
port -v install apg gpg-agent
port -v install py27-docutils
port -v install vim +python27
port -v install git +bash_completion +svn -credential_osxkeychain
port -v install the_silver_searcher
port -v install nmap ngrep htop vnstat iftop bmon libyaml ImageMagick lnav
port -v install cmake gnupg
port -v install openssh
port -v install ffmpeg +nonfree 
port -v install mplayer +smb +mencoder_extras +a52 +aa +noappleremote +osd
port -v install testdisk
port -v install dos2unix 
port -v install go
port -v install pandoc xmlstarlet jq
port -v install mutt +compress

echo "sudo vim /etc/shells"
echo "chsh -s /opt/local/bin/bash $USER"

# https://stribika.github.io/2015/01/04/secure-secure-shell.html
echo "did you generate a ``ed25519`` ssh key yet?"
echo "/opt/local/bin/ssh-keygen -t ed25519 -o -a 100 -f ~/.ssh/id_ed25519"
