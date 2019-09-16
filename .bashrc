# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
HISTFILESIZE=200000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac


# show git branch and status if exist
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1="\u@\h \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "
	color_prompt=

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi


# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


##############
# git aliases/function
##############
trees_root="/home/$USER"

sysg8x(){
  if [ $# -eq 0 ]
    then
      cd "$trees_root/sysg8x"
    else
      cd "$trees_root/sysg8x_$1"
  fi
}

# cd to the root (r)  then into a subdirectory
# example 1: cdr will take you to sysg8x, no matter where you are in your tree
# example 2: "cdr framework/lib" will take you to sysg8x/framework/lib no matter where you are in our tree
cdr(){
	root_dir="$(git rev-parse --show-toplevel)/"
	cd $root_dir$1
}
##############
# ISI aliases/functions 
##############
# build specific parts of the tree from anywhere in your atlas repository
alias close_desktop_nodes="cdr; run/close_desktop_nodes.sh; cd -"
alias update_local_tools="cdr; build/scripts/update_local_tools.py; cd -"
alias export_tree="cdr; build/scripts/export_tree.sh; cd -"
alias y_mount_check="ls -l /isi/app_fs/data/"
alias matlab_sys="cdr domain/app/matlab_sys;"
alias bs="screen -Rd build_screen"

slimshell(){
  cdr
  run/SlimShell.sh "$@" & # allow arguments to be passed to slimshell
  cd -
  return 0
}

launch_desktop_nodes(){
  cdr
  run/launch_desktop_nodes.sh "$@"
  cd -
  return 0
}

desktop_regression_test(){
  cdr
  run/desktop_regression_test.sh "$@"  # allow arguments to be passed to desktop_regression_test
  cd -
  return 0
}



build_atlas(){
  cdr
  make
  cd -
}


build_pc(){
  cdr domain/images/pc/
  make
  cd -
}

###########
# grep aliases
###########
# search all c, cpp, python, .keys and cmake files
alias grepsrc='grep -Rn --include=\*{.c,.h,.cpp,.keys,.m,CMakeLists.txt,.py,.cmake} '

# search all c related files (c, cpp, cmake)
alias grepc='grep -Rn --include=\*{.c,.h,.cpp,CMakeLists.txt,.cmake} '

# search all matlab files
alias grepm='grep -Rn --include=\*.m'

# search all python files
alias greppy='grep -Rn --include=\*.py '

#################
# random aliases
#################
alias code='code -g'


# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
