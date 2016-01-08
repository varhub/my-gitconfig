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

# add git extensions to PATH
declare_path(){
	echo ""
	echo ""
	echo "# git-extensions (my-gitconfig)"
	echo "export PATH=$(pwd)/bin:\$PATH"
}
if test -e $HOME/.profile; then
	grep -q 'my-gitconfig' $HOME/.profile || (declare_path >> $HOME/.profile)
elif test -e $HOME/.bashrc; then
	grep -q 'my-gitconfig' $HOME/.bashrc || (declare_path >> $HOME/.bashrc)
else
	echo "git-extensions could not be installed">&2
fi
