Useful Dotfiles
===============

check out to ``~/.dotfiles`` and symlink relevant files. don't checkout directly
to ``~`` cause otherwise all folders in HOME are recognized as git repo.

Install ``macports`` In Your Home (Working With Mavericks)
----------------------------------------------------------

*update*: quiet a few ports do not compile. probably its a better idea to keep
the ports from lion or mountain lion. 

- install the latest xcode 
- open the latest xcode once
- install macports::

    cd /tmp 
    curl https://distfiles.macports.org/MacPorts/MacPorts-2.2.0.tar.gz|tar xvz
    cd MacPorts-2.2.0/
    PATH="/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin" ./configure --prefix=$HOME/macports --enable-readline --prefix=$HOME/macports --with-install-user=`id -un` --with-install-group=`id -gn` --with-tcl=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk/System/Library/Frameworks/Tcl.framework/ --with-tclinclude=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk/System/Library/Frameworks/Tcl.framework/Versions/8.5/Headers/ && make && make install
    $HOME/macports/bin/port -v selfupdate

- change your ``.profile`` to https://github.com/pansen/dotfiles/blob/master/.profile
- open a new terminal window without closing the current one
- type ``which port`` to see if the exported ``PATH`` is working
- type ``export`` to see if the exported vars make sense
- close the other terminals to avoid confusion
- install ports you like (without ``sudo`` since all is in your ``HOME``)
