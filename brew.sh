# Brew and Brew Cask install commands for new macOS install

# Install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)”

brew update

# Install Brew Packages
brewapps=(
  git
  bash-completion
  exiftool
  trash-cli
  tree
  p7zip
  htop
  postgresql
  sqlite
  graphviz
  mutt
  cmus
  khal
)

brew install "${brewapps[@]}"

# Install Cask
brew tap caskroom/cask

# Install Cask Packages
caskapps=(
  xquartz
  inkscape
  gimp
  anaconda
  google-chrome
  firefox
  flux
  evernote
  dropbox
  idrive
  anki
  atom
  emacs
  virtualbox
  spectacle
  skype
  libreoffice
  mactex
  r-app
  rstudio
  vagrant
  caskroom/versions/microsoft-office-2011
  google-earth-pro
  scrivener
  zotero
)

brew cask install "${caskapps[@]}"

# Install docker - comment out one depending on system reqs
# For post-2010 MacBook Pro systems use 'docker'
# For pre-2010 MacBook Pro systems use 'docker-toolbox'

# brew cask install docker-toolbox
brew cask install docker

# delete .zip, .tar and .dmg files to free up 5GB+ of disk space
brew cask cleanup

brew list
brew cask list
