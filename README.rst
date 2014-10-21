Useful Dotfiles
===============

- install macports

- check out to ``~/.dotfiles`` and symlink relevant files. don't checkout directly
  to ``~`` cause otherwise all folders in HOME are recognized as git repo.

- install all (or a subset as you like) of the configuration files::

    sudo port -v install stow
    cd ~/.dotfiles
    stow bash curl gpg vim
