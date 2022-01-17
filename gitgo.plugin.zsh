if ! command -v fzf &>/dev/null; then
    echo "[gitgo] Missing required dependency!\nPlease install 'fzf' before using this plugin.\nhttps://github.com/junegunn/fzf"
fi

gitgo() {
    local args branch query fetch pull action="checkout"

    if command -v fzf &>/dev/null; then
        args=($@)

        for value in "${args[@]}"; do
            if [ "$value" = "--delete" ] || [ "$value" = "-d" ]; then
                action="delete"
            elif [ "$value" = "--fetch" ] || [ "$value" = "-f" ]; then
                fetch="fetch"
            elif [ "$value" = "--pull" ] || [ "$value" = "-p" ]; then
                pull="pull"
            else
                query="$value"
            fi
        done

        if [ $fetch ]; then
            git fetch --prune --quiet
        fi

        branch=$(git branch --all | fzf --query="$query" --header "What branch do you want to $action?")

        if [ ! -z "$branch" ]; then
            if [ "$action" = "delete" ]; then
                if [[ "$branch" = *"*"* ]]; then
                    git checkout master &>/dev/null

                    if [ $? -ne 0 ]; then
                        git checkout main &>/dev/null
                    fi
                fi

                git branch -d "$(echo $branch | tr -d "*" | sed 's/remotes\/origin\///g' | awk '{$1=$1};1')"
            else
                git checkout "$(echo $branch | tr -d "*" | sed 's/remotes\/origin\///g' | awk '{$1=$1};1')"
            fi

            if [ $pull ]; then
                git pull --prune --quiet
            fi
        fi
    fi
}
