#!/bin/sh

pwd=`pwd`

mv vimrc ~/.vimrc

mkdir -p ~/.vim/colors
cd ~/.vim/colors
wget -O wombat256mod.vim http://www.vim.org/scripts/download_script.php?src_id=13400
cd $pwd




