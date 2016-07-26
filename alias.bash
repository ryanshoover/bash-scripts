# Go to a certain install
function gotopath {
	if [ -d ~/Sites/wpengine/hgv_data/sites/$1/ ] ; then
  		cd ~/Sites/wpengine/hgv_data/sites/$1/
	elif [ -d ~/Sites/$1 ] ; then
		cd ~/Sites/$1
	else
		echo 'No directory found'
		return 1
	fi

	return 0
}

function watchinstall {
	gotopath "$1"

	if (($? < 1)); then
		grunt watch
	fi
}

function name_vagrant {
	cd ~/Sites/$1
	vagrant ${@:2}
	cd -
}


alias wpv='wp ssh --host=vagrant' #or some other host
alias ll="ls -FGAlh $@"
alias goto=gotopath
alias watch=watchinstall
alias v=name_vagrant
alias hobo="VAGRANT_CWD=$WPE_HOME/hobo-cm vagrant"

# Git Alias
alias gs="git status"
alias gd="git diff"
alias gac="! git add . ; git commit -m $1"
alias gp="git push"

# Autocomplete for the goto command
_goto()
{
    local cur prev opts
    cur="${COMP_WORDS[COMP_CWORD]}"
    opts="$(ls -l ~/Sites/wpengine/hgv_data/sites/ | sed -n -e 's/^d.* \([a-zA-Z\_\-]*\)$/\1/p')"
    opts="$opts $(ls -l ~/Sites/ | sed -n -e 's/^d.* \([a-zA-Z\_\-]*\)$/\1/p')"

	COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
	return 0
}

complete -F _goto goto
