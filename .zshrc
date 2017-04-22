autoload -U compinit
compinit -i

# prompt
PROMPT='%m:%c %n$ '

setopt print_eight_bit
export HISTFILE=${HOME}/.zhistory
export HISTSIZE=1000
export SAVEHIST=100000
setopt hist_ignore_dups
setopt EXTENDED_HISTORY
setopt share_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_verify
setopt hist_save_no_dups
setopt hist_no_store
setopt hist_expand
setopt inc_append_history
setopt auto_cd
setopt nonomatch

if [ -f $(brew --prefix)/etc/brew-wrap ];then
  source $(brew --prefix)/etc/brew-wrap
fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

# Java setting
export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)

if [ -z "$ANDROID_HOME" ]; then
  export ANDROID_HOME=$HOME/Library/Android/sdk
  export PATH="$JAVA_HOME/bin:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$PATH"
fi

# Go setting
if [ -z "$GOPATH" ]; then
  export GOPATH=$HOME/go
  export PATH="$GOPATH/bin:$PATH"
fi

# anyenv setting
if [ -z "$ANYENV_HOME" ]; then
  export ANYENV_HOME=$HOME/.anyenv
  export PATH="$ANYENV_HOME/bin:$PATH"
  eval "$(anyenv init - --no-rehash)"
fi

export GHQ_ROOT="$(ghq root)"

# zplug
source $GHQ_ROOT/github.com/zplug/zplug/init.zsh
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "plugins/git", from:oh-my-zsh
if ! zplug check; then
  zplug install
fi
zplug load


# Alias
alias updatedb='sudo /usr/libexec/locate.updatedb'
alias glp='yarn run gulp'
alias src='source ~/.zshrc'

if (which zprof > /dev/null) ;then
  zprof | less
fi
