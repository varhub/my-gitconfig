#!/bin/sh


link_file(){
name=$1
source=$(pwd)/$name
target=~/$name

if [ -e "$target" ]; then
	if [ "$2" = "-f" ]; then
		rm "$target"
	else
		echo "$name already exists. abort..."
		return 1
	fi
fi

ln -s "$source" "$target"
if [ $? -eq 0 ]; then
	echo "$name installed successfully"
fi
}

force_install=$1

# install gitconfig
name=.gitconfig
link_file $name $force_install

#install global ignore
name=.gitignore_global
link_file $name $force_install
git config --global core.excludesfile \~/$name
