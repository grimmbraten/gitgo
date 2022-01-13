if ! command -v fzf &>/dev/null; then
    echo "Please install fzf before using this plugin."
fi

gitgo() {
    local branch

    if [ -z "$1" ]; then
        branch=$(git branch | fzf)

    else
        branch=$(git branch | fzf --query="$1")
    fi

    if [ ! -z "$branch" ]; then
        git checkout "$(echo $branch)"
    fi
}
