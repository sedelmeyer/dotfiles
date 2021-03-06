# Add to $PATH
PATH=$PATH:/Library/PostgreSQL/9.6/bin
# added by Anaconda3 5.0.0 installer
export PATH="/Users/sedelmeyer/anaconda3/bin:$PATH"

# Aliases
alias ls='ls -GFh'
alias rm='rm -i'

# Enable git tab completion
source ~/git-completion.bash

# Enable bash-completion from brew bash-completion install
if [ -f $(brew --prefix)/etc/bash_completion ]; then
. $(brew --prefix)/etc/bash_completion
fi

# colors!
green="\[\033[0;32m\]"
blue="\[\033[0;34m\]"
cyan="\[\033[0;36m\]"
purple="\[\033[0;35m\]"
reset="\[\033[0m\]"

# Change command prompt
source ~/git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=1
# '\u' adds the name of the current user to the prompt
# '\$(__git_ps1)' adds git-related stuff
# '\W' adds the name of the current directory
export PS1="$purple\u$green\$(__git_ps1)$cyan \W $ $reset"

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
