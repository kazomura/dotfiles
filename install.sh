for dotfile in .??*; do
  [[ $dotfile = ".git" ]] && continue
  [[ $dotfile = ".gitignore" ]] && continue
  ln -snfv "$PWD/$dotfile" "$HOME/$dotfile"
done

source $HOME/.zshenv

echo "brew install..."
brew file install

if [ ! -f "$HOME/.go/bin/ghq" ]; then
  echo "install ghq..."
  go get github.com/motemen/ghq
  GHQ_ROOT="$(ghq root)"
fi

if [ ! -f "$HOME/.go/bin/peco" ]; then
  echo "install peco..."
  go get github.com/peco/peco/cmd/peco
fi

if [ ! -d "$GHQ_ROOT/github.com/zplug/zplug" ]; then
  echo "install zplug..."
  $HOME/.go/bin/ghq get git://github.com/zplug/zplug
fi

if [ ! -d "$GHQ_ROOT/github.com/riywo/anyenv" ]; then
  echo "install anyenv..."
  $HOME/.go/bin/ghq get git://github.com/riywo/anyenv
fi
ln -snfv "$GHQ_ROOT/github.com/riywo/anyenv" "$HOME/.anyenv"
ANYENV_ROOT=$HOME/.anyenv

if [ ! -d "$ANYENV_ROOT/envs/rbenv" ]; then
  echo "install rbenv..."
  $ANYENV_ROOT/bin/anyenv install rbenv
  echo "install ruby..."
  rbenv install 2.4.1
  rbenv global 2.4.1
fi

if [ ! -d "$ANYENV_ROOT/envs/pyenv" ]; then
  echo "install pyenv..."
  $ANYENV_ROOT/bin/anyenv install pyenv
  echo "install python..."
  pyenv install 3.6.1
  pyenv global 3.6.1
fi

if [ ! -d "$ANYENV_ROOT/envs/ndenv" ]; then
  echo "install ndenv..."
  $ANYENV_ROOT/bin/anyenv install ndenv
  echo "install node..."
  ndenv install v7.9.0
  ndenv global v7.9.0
fi

eval "$(anyenv init - )"
