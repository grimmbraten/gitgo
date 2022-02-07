if ! command -v fzf &>/dev/null; then
    echo "[gitgo] Missing required dependency!\nPlease install 'fzf' before using this plugin.\nhttps://github.com/junegunn/fzf"
fi

gitgo() {
    local args branch query fetch pull quiet action="checkout"

    if command -v fzf &>/dev/null; then
        args=($@)

        for value in "${args[@]}"; do
            if [ "$value" = "--delete" ] || [ "$value" = "-d" ]; then
                action="delete"
            elif [ "$value" = "--fetch" ] || [ "$value" = "-f" ]; then
                fetch="fetch"
            elif [ "$value" = "--pull" ] || [ "$value" = "-p" ]; then
                pull="pull"
            elif [ "$value" = "--quiet" ] || [ "$value" = "-q" ]; then
                quiet="--quiet"
            else
                query="$value"
            fi
        done

        if [ $fetch ]; then
            git fetch --all --prune $quiet
        fi

        branch=$(git branch --all | fzf --query="$query" --exit-0 --select-1 --header "What branch do you want to $action?" | tr -d "*" | sed 's/remotes\/origin\///g' | awk '{$1=$1};1')

        if [ ! -z "$branch" ]; then
            if [ "$action" = "delete" ]; then
                if [[ "$branch" = $(git name-rev --name-only HEAD) ]]; then
                    git checkout master &>/dev/null

                    if [ $? -ne 0 ]; then
                        git checkout main &>/dev/null
                    fi
                fi

                git branch -D "$(echo $branch)"
            else
                git checkout "$(echo $branch)"
            fi

            if [ $pull ]; then
                git pull --prune $quiet
            fi
        fi
    fi
}
