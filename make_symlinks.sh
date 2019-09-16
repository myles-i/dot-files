#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in repo wher this script is
############################

########## Variables

self_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
backup_dir=~/backup_dotfiles/$(date "+%Y-%m-%d_%H-%M-%S")             # old dotfiles backup directory
files=".bashrc .inputrc .vimrc"    # list of files/folders to symlink in homedir

# move any existing dotfiles in homedir to backup_dir directory, then create symlinks 
for file in $files; do
    source_file="$self_dir/$file"
    destination_file="/home/$USER/$file"

    if [ -f $destination_file ]; then
        if [ ! -f $backup_dir ];then
            mkdir -p $backup_dir
        fi
        echo "Backup up existing file $destination_file to $backup_dir"
        mv $destination_file $backup_dir/
    fi
done
echo ""

for file in $files; do
    source_file="$self_dir/$file"
    destination_file="/home/$USER/$file"
    echo "Creating symlink to $source_file in home directory."
    ln -snf $source_file $destination_file 
done
echo ""
echo "Close and relaunch terminal for all dot files to take effect..."
