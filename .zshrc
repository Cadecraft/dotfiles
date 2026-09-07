# Zsh Config (with Oh My Zsh)
# R: v0.2.0, E: 2024/07/29

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Clone Oh My Zsh into this directory:
export ZSH="$HOME/.oh-my-zsh"

# <https://github.com/ohmyzsh/ohmyzsh/wiki/Themes>
ZSH_THEME="agnoster"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Configuration for plugins
function zvm_config() {
	ZVM_CURSOR_STYLE_ENABLED=false
	ZVM_VI_HIGHLIGHT_BACKGROUND=blue
	ZVM_VI_HIGHLIGHT_FOREGROUND=black
}

# Load plugins
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(git)
# `jeffreytse/zsh-vi-mode` must be cloned into `$ZSH_CUSTOM/plugins/zsh-vi-mode`
# plugins+=(zsh-vi-mode)

source $ZSH/oh-my-zsh.sh

. "$HOME/.cargo/env"

# User configuration

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Example:
# - `$ZSH_CUSTOM/.aliases.zsh`
# Example aliases
# - `alias zshconfig="mate ~/.zshrc"`
