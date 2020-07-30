# ---------------------------------------- #
# Exports and Paths
# ---------------------------------------- #
export PATH="$HOME/bin:$HOME/Homebrew/bin:${PATH}"

# ---------------------------------------- #
#  Antibody
# ---------------------------------------- #

autoload -Uz compinit
if [ $(date +'%j') != $(stat -f '%Sm' -t '%j' ~/.zcompdump) ]; then
  compinit
else
  compinit -C
fi

source ~/code/setup/.zsh_plugins.sh

# ---------------------------------------- #
#  Custom
# ---------------------------------------- #

export HOMEBREW_NO_AUTO_UPDATE="1"
export DEFAULT_BROWSER="Safari"
export EDITOR="vim"
export LANG="en_US.UTF-8"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse"

# Online cheatsheet
function cheat(){
        curl "cheat.sh/$1"
}

# Jump to project bookmark
jump() {
  local dir
  dir=$(cat ~/code/.bookmarks| fzf ) &&
  cd "$dir"
  zle reset-prompt
}
zle -N jump

# Open repository in default browser
func repo(){
        if [ -d .git ]; then
                open -a $DEFAULT_BROWSER $(git remote get-url upstream | sed 's|.git$||g');
        else
                echo "Not a git repository!";
        fi;
}

# Saving initial prompt before timestamp changes
INITIAL_PROMPT=$PROMPT
# Don't show timestamp anymore
function timeoff() {
  # Prompt from theme gianu
  PROMPT=$INITIAL_PROMPT
}
# Show timestamp in prompt header
function timeon() {
  PROMPT='[%*] '$PROMPT
}


# ---------------------------------------- #
#  Aliases
# ---------------------------------------- #

alias bmadd='echo $(pwd) >> /Users/$USER/code/.bookmarks'
alias ignore='function(){ curl -sLw "\n" https://www.gitignore.io/api/$@ ;}'
alias cpwd='pwd|tr -d "\n"|pbcopy'
alias pq='parquet-tools'
alias src="source /Users/$USER/.zshrc"

# ---------------------------------------- #
#  Bindkeys
# ---------------------------------------- #

bindkey -e
bindkey '\e\e[C' forward-word
bindkey '\e\e[D' backward-word
bindkey "^j" jump

# ---------------------------------------- #
#  Language version managers
# ---------------------------------------- #

# NOTE: pyenv and goenv are lazy-loaded in the below commands
# The reason the behavior has been changed is to reduce shell startup latency
# Inspired by: https://carlosbecker.com/posts/speeding-up-zsh/

pyenv() {
  eval "$(command pyenv init - zsh --no-rehash)"
  pyenv "$@"
}

goenv() {
	eval "$(command goenv init - zsh)"
	goenv "$@"
}


# ---------------------------------------- #
#  SDKMAN
# ---------------------------------------- #
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/manojkarthick/.sdkman"
[[ -s "/Users/manojkarthick/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/manojkarthick/.sdkman/bin/sdkman-init.sh"
