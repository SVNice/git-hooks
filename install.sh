#!/usr/bin/env bash
# 
#
search_for_local_repos=true
install_tox=true
install_hooks=["all"] # Just passing all will install all hooks in ./hooks/
# Get all arguments and process them

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