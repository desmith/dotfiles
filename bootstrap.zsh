#!/usr/bin/env zsh

me=${(%):-%N}
opt_param=$1

cd ~/.dotfiles

platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
	platform='linux'
	myhome=/home/ubuntu
elif [[ "$unamestr" == 'Darwin' ]]; then
	platform='freebsd'
	myhome=${HOME}
fi

DOTDIR="${HOME}/.dotfiles"

### dirs
dotdirs=(
	.ansible
	.atom
	.byobu
	.certs
	.cheatsheets
	.config
	.gitosis-admin
	.git-templates
	.ipython
	.iterm2
	.local
	.pip
	.SpaceVim.d
	.terminfo
	.tmux
	.tmuxinator
)

### files
dotfiles=(
	.ansible.cfg
	.ansible_galaxy
	ecs.config
	.gemrc
	.gitconfig
	.gitattributes
	.gitexcludes
	.gitignore
	.gitignore_global
	.gitk
	.inputrc
	.nvimrc
	.npmrc
	.pylintrc
	.pyhistory
	.pythonrc.py
	.python-gitlab.cfg
	.rclone.conf
	.screenrc
	.serverlessrc
	stylelint.config.js
	.tmux.conf
	.vuerc
	.wgetrc
	.yazclientrc
)

tmpdirs=(
	~/.Trash
)


function doIt() {
	echo "running doIt() ..."

	mkdir -p ~/.venvs
	ln -s -f ${DOTDIR}/.venvs/global_requirements.txt ~/.venvs/

	for dir in $dotdirs; do
		echo "creating directory symlink: $dir..."
		ln -s -f ${DOTDIR}/$dir ~
	done

	for file in $dotfiles; do
		echo "creating file symlink: $file..."
		ln -s -f ${DOTDIR}/$file ~
	done

	if [[ ${platform} == 'linux' ]]; then
		ln -s -f ${DOTDIR}/.aliases_linux ~/.aliases
		ln -s -f ${DOTDIR}/.linuxbrew ~
	fi

	if [[ ${platform} == 'freebsd' ]]; then
		ln -s -f ${DOTDIR}/.aliases_osx ~/.aliases
		ln -s -f ${HOME}/Dropbox/etc ~
		ln -s -f ${DOTDIR}/.hammerspoon ~
	fi

	for dir in $tmpdirs; do
		if [[ ! -d $dir ]]; then
			echo "creating directory $dir..."
			mkdir $dir
		fi
	done

	echo "done!"
}


function unDoIt() {
	echo "running unDoIt() ..."
	rm -f ${HOME}/.venvs/global_requirements.txt

	for dir in $dotdirs; do
		echo "removing directory symlink: $dir..."
		rm  -f "${HOME}/$dir"
	done

	for file in $dotfiles; do
		echo "removing file symlink: $file..."
		rm  -f "${HOME}/$file"
	done

	for file in $zdotfiles; do
		echo "removing file symlink: $file..."
		rm  -f "${HOME}/$file"
	done

	if [[ ${platform} == 'linux' ]]; then
		rm -f ${HOME}/.linuxbrew
	elif [[ ${platform} == 'freebsd' ]]; then
		rm -f ${HOME}/etc
		rm -f ${HOME}/.hammerspoon
	fi

	echo "Undone!"

}

echo "\$opt_param: $opt_param"

if [[ $opt_param == 'install' ]]; then
	doIt
elif [[ $opt_param == 'remove' ]]; then
	unDoIt
else
	doIt
fi

unset doIt
unset unDoIt
