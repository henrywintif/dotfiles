# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

#Plugins
## powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

## 
zinit load zsh-users/zsh-syntax-highlighting

zinit load zsh-users/zsh-autosuggestions

##oh-my-zsh stuff
###libs
zi snippet OMZL::functions.zsh
zi snippet OMZL::completion.zsh
zi snippet OMZL::clipboard.zsh
zi snippet OMZL::termsupport.zsh
zi snippet OMZL::history.zsh
zi snippet OMZL::compfix.zsh
zi snippet OMZL::key-bindings.zsh
#zi snippet OMZL::history.zsh
#zi snippet OMZL::history.zsh
#zi snippet OMZL::history.zsh
#zi snippet OMZL::history.zsh
###
#zi snippet OMZP::tmux
#zi snippet OMZP::colored-man-pages
#zi snippet OMZP::colorize
#zi snippet OMZP::command-not-found
#zi snippet OMZP::copybuffer
#zi snippet OMZP::copypath
#zi snippet OMZP::copyfile
#zi snippet OMZP::command-not-found
#zi snippet OMZP::safe-paste
#zi snippet OMZP::web-search
