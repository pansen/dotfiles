#!/bin/bash
set -e
port -v install python27 py27-readline
port -v install python35 py35-readline
port -v install ruby23
port select --set ruby ruby23
port -v install elixir
port -v install coreutils bash bash-completion stow realpath
port -v install tree grep rsync watch jq pv
port -v install apg gpg-agent
port -v install duplicity duply
port -v install py27-docutils
port -v install vim +python27
port -v install git +bash_completion +svn -credential_osxkeychain
port -v install colordiff
port -v install maven32
port -v install the_silver_searcher
port -v install nmap ngrep htop vnstat iftop bmon libyaml ImageMagick lnav
port -v install cmake gnupg
port -v install openssh
port -v install ffmpeg +nonfree 
port -v install mplayer +smb +mencoder_extras +a52 +aa +noappleremote +osd
port -v install mkvtoolnix +wxwidgets
port -v install testdisk
port -v install dos2unix 
# iperf -c 10.0.0.20 -fM -t100
port -v install iperf
port -v install go
port -v install qemu
port -v install postgresql95 +python
port -v install pandoc xmlstarlet jq
port -v install mutt +compress
# for http://keepass.info/download/p_macosx/index.html
# also install http://www.xquartz.org/
port -v install mono

echo "sudo vim /etc/shells"
echo "chsh -s /opt/local/bin/bash $USER"

# https://stribika.github.io/2015/01/04/secure-secure-shell.html
echo "did you generate a ``ed25519`` ssh key yet?"
echo "/opt/local/bin/ssh-keygen -t ed25519 -o -a 100 -f ~/.ssh/id_ed25519"
