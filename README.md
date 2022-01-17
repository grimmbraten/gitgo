A zsh plugin that helps you checkout and delete git branches with a single command.

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

Apply search query from plugin command

```bash
gitgo -d error

>   bugfix/resolve-418-status-code-error
  What branch would you like to delete?
  1/4
> error
```

Checkout branch (without pulling the latest remote origin changes)

```bash
gitgo feature/work-in-progress --freeze

>   feature/work-in-progress
  What branch would you like to delete? (freeze)
  1/4
> error
```

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
