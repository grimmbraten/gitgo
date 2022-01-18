A zsh plugin to go between git branches with ease

## Install

![license](https://img.shields.io/github/license/grimmbraten/gitgo?style=flat&color=blue)
![size](https://img.shields.io/github/repo-size/grimmbraten/gitgo?style=flat&color=blue)

```bash
brew install fzf && git clone git@github.com:grimmbraten/gitgo.git $ZSH_CUSTOM/plugins/gitgo
```

Add `gitgo` to the plugin array in your `.zshrc` file.

```bash
plugins=(...other-plugins gitgo)
```

## Use

Checkout a branch

```bash
gitgo

>   feature/implement-new-feature
    feature/work-in-progress
  * master
    bugfix/resolve-418-status-code-error
  What branch would you like to checkout?
  4/4
> _
```

Checkout a branch (and update remote references)

```bash
gitgo --fetch

>   feature/implement-new-feature
    feature/work-in-progress
  * master
    bugfix/resolve-418-status-code-error
  What branch would you like to checkout?
  4/4
> _
```

Checkout branch (and pull the latest changes)

```bash
gitgo feature/work-in-progress --pull

>   feature/work-in-progress
  What branch would you like to checkout?
  1/4
> feature/work-in-progress
```

Delete a local branch

```bash
gitgo --delete

>   feature/implement-new-feature
    feature/work-in-progress
  * master
    bugfix/resolve-418-status-code-error
  What branch would you like to delete?
  4/4
> _
```

### Flags

`--fetch` / `-d`: Fetch and update remote-tracking references and remove any remote-tracking references that no longer exist.

`--pull` / `-p`: Either fast-forward or reconcile the divergent local branch and remove any remote-tracking references that no longer exist.

`--delete` / `-d`: Delete local fully upstream or HEAD branch.

## Upgrade

![GitHub last commit](https://img.shields.io/github/last-commit/grimmbraten/gitgo?style=flat&color=blue)
![GitHub open issues](https://img.shields.io/github/issues-raw/grimmbraten/gitgo?style=flat&color=blue)

```bash
$ git -C $ZSH_CUSTOM/plugins/gitgo pull
```

## Uninstall

```bash
rm -rf $ZSH_CUSTOM/plugins/gitgo
```

![GitHub Repo stars](https://img.shields.io/github/stars/grimmbraten/gitgo?style=social)

## Credits

This simple zsh git plugin is possible because of the amazing [junegunn/fzf](https://github.com/junegunn/fzf) command-line fuzzy finder.
