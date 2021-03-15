# Lines configured by zsh-newuser-install
HISTFILE=$HOME/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt autocd beep extendedglob nomatch
bindkey -e

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '$HOME/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# ---------------------------------------- #
#  Antibody
# ---------------------------------------- #
source "$HOME/code/dotfiles/zsh/antibody/.zsh_plugins.sh"

# ---------------------------------------- #
#  Fzf
# ---------------------------------------- #
[ -f /etc/profile.d/fzf.zsh ] && source "/etc/profile.d/fzf.zsh"
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse"

eval "$(starship init zsh)"
