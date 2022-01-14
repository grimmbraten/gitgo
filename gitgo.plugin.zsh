if ! command -v fzf &>/dev/null; then
    echo "[gitgo] Missing required dependency 'fzf'\nPlease install it before using this plugin.\nnhttps://github.com/junegunn/fzf"
fi

gitgo() {
    local args branch query action="checkout"

    if command -v fzf &>/dev/null; then
        args=($@)

        for value in "${args[@]}"; do
            if [ "$value" = "--delete" ] || [ "$value" = "-d" ]; then
                action="delete"
            else
                query="$value"
            fi
        done

        if [ -z "$query" ]; then
            branch=$(git branch | fzf --header "What branch do you want to $action?")

        else
            branch=$(git branch | fzf --query="$query" --header "What branch do you want to $action?")
        fi

        if [ ! -z "$branch" ]; then
            if [ "$action" = "delete" ]; then
                if [[ "$branch" = *"*"* ]]; then
                    git checkout master &>/dev/null

                    if [ $? -ne 0 ]; then
                        git checkout main &>/dev/null
                    fi
                fi

                git branch -d "$(echo $branch | tr -d "*" | awk '{$1=$1};1')"
            else
                git checkout "$(echo $branch | awk '{$1=$1};1')"
            fi
        fi
    else
        echo "[gitgo] Please install missing plugin dependency 'fzf'\nhttps://github.com/junegunn/fzf"
    fi
}
