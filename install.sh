#!/usr/bin/env bash
# 
#
search_for_local_repos=true
install_tox=true
install_hooks=["all"] # Just passing all will install all hooks in ./hooks/
# Get all arguments and process them
args=("$@")
index=0
# If argument is not empty
while [[ -n "${args[$index]}" ]]; do
   current_arg="${args[$index]}"
   case "$current_arg" in
           "--test" | "-t")
                   index=$index+1
                   echo "test arg is ${args[$index]}"
                   ;;
           *)
                   echo "Unkown argument $current_arg"
                   exit 1
   esac
   index=$index+1
done


# Get all local repos to install the local hooks into



local_repos="$HOME/test"
# Install hooks
for repo in local_repos; do
    echo "Installing hooks into repo: "+repo
    cp -r hooks $repo/.git/hooks
    # TODO make this more intelgent and only make execuatable our files
    chmod +x $repo/.git/hooks/*
done

echo "Done"