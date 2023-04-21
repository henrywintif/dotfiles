# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git docker docker-compose timer)

# Plugin settings
TIMER_THRESHOLD=1

source $ZSH/oh-my-zsh.sh

# This modifies the git_prompt_info script to only
# run inside workspace subdirectories
function git_prompt_info_wrapper() {
	if [[ $PWD = */workspace/* ]];
	then
		git_prompt_info;
	fi
}

# This is the robbyrussel PROMPT, but using our git prompt wrapper
# We do this because our config is a git repo, and we don't want
# our prompt to display the status of that config repo anytime we're
# in our home directory
PROMPT="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"
PROMPT+=' %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info_wrapper)'

# Environment variables
export WORKSPACE_DIR=$HOME/workspace

# Aliases
alias sudo='sudo '

export PATH="$HOME/.poetry/bin:$HOME/.local/bin:$PATH"
