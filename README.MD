Configiration files

Inspired by https://github.com/alecho/dot-files/

### How to instal

## Step 1. Install required packages

```
[brew/apt] install ...
zsh
stow
...
```

### Step 2. Pull the repository, and then create the symbolic links using GNU stow.

```bash
git clone git@github.com:nparker-tc/dotfiles ~/.dotfiles
cd ~/.dotfiles
ls -d */ | xargs stow
```

