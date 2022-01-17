if ! command -v fzf &>/dev/null; then
    echo "[gitgo] Missing required dependency 'fzf'\nPlease install it before using this plugin.\nnhttps://github.com/junegunn/fzf"
fi

gitgo() {
    local args branch query special action="checkout"

    if command -v fzf &>/dev/null; then
        args=($@)

        for value in "${args[@]}"; do
            if [ "$value" = "--delete" ] || [ "$value" = "-d" ]; then
                action="delete"
            elif [ "$value" = "--freeze" ] || [ "$value" = "-f" ]; then
                special="(freeze)"
            else
                query="$value"
            fi
        done

        branch=$(git branch --all | fzf --query="$query" --header "What branch do you want to $action? $special")

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

            if [ "$special" != "(freeze)" ]; then
                git pull --prune --quiet
            fi
        fi
    else
        echo "[gitgo] Please install missing plugin dependency 'fzf'\nhttps://github.com/junegunn/fzf"
    fi
}
