# completion
autoload -Uz compinit
compinit

if [ -n "$LS_COLORS" ]; then
 zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
fi

# lang
export LANG=ja_JP.UTF-8

# show japanese files
setopt print_eight_bit

# set comment as #
setopt interactive_comments

# unset correction
unsetopt correctall

# arround ruby
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# heroku toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# depot_tools
export PATH="$PATH":`pwd`/depot_tools

# export ~/bin
export PATH="~/bin:$PATH"

# added by travis gem
source /Users/sensui_shogo/.travis/travis.sh

# use nvm
[[ -s ~/.nvm/nvm.sh ]] && . ~/.nvm/nvm.sh

