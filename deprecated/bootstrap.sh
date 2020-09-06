# Generate
echo Generate SSH key for GitHub account
ssh-keygen -t rsa -b 4096 -C "github-email-address@domain.com"
eval "$(ssh-agent -s)"

echo Copy SSH key to clipboard
ssh-add -K ~/.ssh/id_rsa
pbcopy < ~/.ssh/id_rsa.pub

echo NEXT STEPS: Got to GitHub account online and add SSH key to your account (paste from clipboard)
git clone git@github.com:sedelmeyer/dotfiles.git


# Create symlinks to dotfiles
ln -s ~/dotfiles/.bash_profile ~/.bash_profile
ln -s ~/dotfiles/.emacs ~/.emacs
ln -s ~/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/dotfiles/.inputrc ~/.inputrc
ln -s ~/dotfiles/git-completion.bash ~/git-completion.bash
ln -s ~/dotfiles/git-prompt.sh ~/git-prompt.sh
