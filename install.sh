#!/bin/sh


name=.gitconfig
file=$(pwd)/$name
target=~/$name


if [ -e "$target" ]; then
	if [ "$1" = "-f" ]; then
		rm "$target"
	else
		echo "$name already exists. abort..."
		exit 0
	fi
fi

ln -s "$file" "$target"
if [ $? -eq 0 ]; then
	echo "$name installed successfully"
fi

