#!/usr/bin/env bash
# Install script to install git hooks into git repos and install needed programs
# for said scripts.
install_default_git=true
search_for_local_repos=true
hooks=(hooks/python/*)

git_template_location=/usr/share/git-core/templates

local_repos=()
# Get all arguments and process them
args=("$@")
index=0
# If argument is not empty
while [[ -n "${args[$index]}" ]]; do
    current_arg="${args[$index]}"
    case "$current_arg" in
        "--help")
echo "Install script for git hooks. Automatically installs into
all repos found under the HOME directory.
FLAGS:
    --dir -d    Select sepcfic repo to install to. Must be the
    the root of the repo
    --help      View this help test
    --hook -h   To Install a specific hook. Can use globing."
            exit 0
            ;;
        "--dir" | "-d")
            index=$index+1
            local_repos+=("${args[$index]}")
            search_for_local_repos=false
            ;;
        "--no-default" | "-n")
            install_default_git=false
            ;;
        "--hook" | "-h")
            index=$index+1
            hooks=("${args[$index]}")
            ;;
        *)
            echo "Unkown argument $current_arg"
            exit 1
    esac
    index=$index+1
done

# Get all local repos to install the local hooks into
if [[ $search_for_local_repos == "true" ]]; then 
    local_repos=$(find $HOME -name ".git")
fi

# Install hooks
for repo in $local_repos; do
    echo "Installing hooks into repo: $repo"
    for hook in $hooks; do
        echo "loop"
        hook=echo $hook | sed -rn 's/.*hooks\/(.*)/\1/p'
        cp "$hook" "$repo/git/hooks/"
        chmod +x "$repo/git/$hook"
    done
done

# Install to default repo
if [[ $install_default_git == "false" ]]; then
    for hook in $hooks; do
        echo "loop"
        hook=echo $hook | sed -rn 's/.*hooks\/(.*)/\1/p'
        cp "$hook" "$repo/git/hooks/"
        chmod +x "$repo/git/$hook"
    done
done

echo "Done"