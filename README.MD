Configiration files

Inspired by https://github.com/alecho/dot-files/

### How to instal

## Step 1. Install required packages

```
[brew/apt] install ...
zsh
stow
https://github.com/dandavison/delta (git-delta)
...
```

### Step 2. Pull the repository, and then create the symbolic links using GNU stow.

```bash
gh repo clone nparker-tc/dotfiles ~/.dotfiles
cd ~/.dotfiles
ls -d */ | xargs stow
```

### Step 3. Install oh-my-zsh

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### iTerm2 Color Scheme

https://github.com/mbadolato/iTerm2-Color-Schemes#dracula-1
```
gh repo clone mbadolato/iTerm2-Color-Schemes ~/Developer/tools/
cd ~/Developer/tools/iTerm2-Color-Schemes
tools/import-scheme.sh 'Dracula+'

### Zsh Plugins
1. zsh-autocomplete https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#oh-my-zsh

### Other tools
delta
git checkout-interactive https://github.com/kaunteya/git-checkout-interactive/
