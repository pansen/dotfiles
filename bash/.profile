# ------------------------------------------
# Misc. Environment
# ------------------------------------------
if [ "Darwin"=="$(uname)" ]; then
    SW_VERS=$(which sw_vers)
    if [ -x $SW_VERS ] && [ "10.9"==`$SW_VERS|grep ProductVersion|awk '{print $2}'` ];then
      export PORTS_PREFIX=/opt/local
    else
      export PORTS_PREFIX=/opt/local
    fi
    # only export this on mac, should not be required in linux
    export MAGICK_HOME=$PORTS_PREFIX
else
    export PORTS_PREFIX=/usr
fi

export EDITOR=vim
export GREP_COLOR='1;32'

# export VAGRANT_DEFAULT_PROVIDER=vmware_fusion
export LC_CTYPE=en_US.UTF-8
export LANG=en_US.UTF-8
# set JDK for PyCharm and stuff:
# https://intellij-support.jetbrains.com/entries/23455956-Selecting-the-JDK-version-the-IDE-will-run-under
# install java 1.7
# http://stackoverflow.com/a/19737307/3093179
# http://stackoverflow.com/a/18144853/2741111
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_40.jdk/Contents/Home
export ANT_HOME=/usr/share/ant
export GRADLE_HOME=$PORTS_PREFIX/share/java/gradle
export GRAILS_HOME="$PORTS_PREFIX/share/java/grails"
export CFLAGS="-O2 -pipe"
export CXXFLAGS="${CFLAGS}"
export MAKEOPTS="-j9"
export PYTHONSTARTUP=~/.pythonstartup
export M2_REPO=~/.m2
export ANDROID_HOME=/Library/Android/android-sdk-mac_x86
export PIP_DOWNLOAD_CACHE=$HOME/Library/Caches/pip-downloads

export C_INCLUDE_PATH=$PORTS_PREFIX/include
export CXX_INCLUDE_PATH=$PORTS_PREFIX/include
export CPATH=$PORTS_PREFIX/include
export LIBRARY_PATH=$PORTS_PREFIX/lib
# this seems to be a bad idea
# http://stackoverflow.com/questions/20915752/oserror-dlopenlibsystem-dylib-6-image-not-found-os-x-macports-celery
# export DYLD_FALLBACK_LIBRARY_PATH=$PORTS_PREFIX/include:$PORTS_PREFIX/lib
export CPPFLAGS="-I$PORTS_PREFIX/include"
# export CC="$(xcode-select --print-path)/usr/bin/cpp"

export PYRAMID_DEBUGTOOLBAR=0

# for https://github.com/sickill/stderred
# export DYLD_INSERT_LIBRARIES=${HOME}/project/stderred/lib/stderred.dylib
# export DYLD_FORCE_FLAT_NAMESPACE=1

export JAVA_OPTS="-Xms256m -Xmx2048m" 
export MAVEN_OPTS="-Xms256m -Xmx2048m"
PERL_VERSION=$(file `which perl`|grep 'symbolic link'|awk '{print $5}'|tr -d "\`\'")

# ------------------------------------------
# PATH
# ------------------------------------------

export PATH="~/bin:$PATH"
export PATH="$PORTS_PREFIX/bin:$PATH"
export PATH="$PORTS_PREFIX/sbin:$PATH"
export PATH="$PATH:/opt/local/Library/Frameworks/Python.framework/Versions/2.7/bin"
export PATH="$PATH:/System/Library/Frameworks/JavaVM.framework/Versions/1.6.0/Home/bin"
export PATH=$PATH:~/Library/android-sdk-macosx/tools
# export PATH=$PATH:"/Applications/VMware Fusion.app/Contents/Library"
export PATH="$PATH":"${ANDROID_HOME}/platform-tools"
export PATH="$PATH":"${ANDROID_HOME}/tools"
export PATH="$PATH":"$PORTS_PREFIX/libexec/perl$PERL_VERSION"
export PATH="$PATH":"$HOME/homebrew/bin"
export PATH="$PATH":"$HOME/.cargo/bin"
