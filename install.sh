#!/usr/bin/env bash

if [ ! -e ~/.gitconfig ]; then
  ln -vsf ~/yuan-vim/gitconfig ~/.gitconfig
fi

if [ ! -e ~/.config/nvim ]; then
  ln -vsf ~/yuan-vim/nvim ~/.config/nvim
fi

if [ -f ~/.zprofile ]; then
  for helper in ~/yuan-vim/helper/*.helper; do
  cat << EOF >> ~/.zprofile
source ${helper}
EOF
  done
fi

echo "Install Success !"
