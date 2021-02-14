#1/bin/bash

# Current script requires that we be in the dotfiles working
# directory when run by bash. This needs to be fixed.

# SOURCE: This script is adapted from
# https://github.com/tomnomnom/dotfiles/blob/master/setup.sh
dotfilesDir="$(pwd)/dotfiles"

function linkDotfile {
  dest="${HOME}/${1}"
  dateStr=$(date +%Y-%m-%d-%H%M)

  if [ -h ~/${1} ]; then
    # Existing symlink 
    echo "Removing existing symlink: ${dest}"
    rm ${dest} 

  elif [ -f "${dest}" ]; then
    # Existing file
    echo "Backing up existing file: ${dest}"
    mv ${dest}{,.${dateStr}}

  elif [ -d "${dest}" ]; then
    # Existing dir
    echo "Backing up existing dir: ${dest}"
    mv ${dest}{,.${dateStr}}
  fi

  echo "Creating new symlink: ${dest}"
  ln -s ${dotfilesDir}/${1} ${dest}
}

linkDotfile .vimrc
linkDotfile .bashrc
linkDotfile .gitconfig
linkDotfile .tmux.conf
linkDotfile .inputrc
linkDotfile .cookiecutterrc
linkDotfile .i3
linkDotfile .vifm
linkDotfile .muttrc
linkDotfile .mutt
