# ---------------------------------------- #
# Exports and Paths
# ---------------------------------------- #
# Use Array style path initiation for cleaner look
# Inspired by: https://github.com/BrodieRobertson/dotfiles/blob/master/.zshenv
typeset -U PATH path
path=(
		"$HOME/bin"
		"$HOME/Homebrew/bin"
		"$HOME/.cargo/bin"
		"$HOME/Homebrew/opt/gnu-getopt/bin"
		"$HOME/.krew/bin"
		"$path[@]"
)
export PATH

# ---------------------------------------- #
#  Antibody
# ---------------------------------------- #
# Automatically load compinit only once per day
# Inspired by: https://gist.github.com/ctechols/ca1035271ad134841284
autoload -Uz compinit
if [ $(date +'%j') != $(stat -f '%Sm' -t '%j' ~/.zcompdump) ]; then
		compinit
else
		compinit -C
fi

source "$HOME/code/dotfiles/zsh/antibody/.zsh_plugins.sh"

# ---------------------------------------- #
#  Custom
# ---------------------------------------- #

export HOMEBREW_NO_AUTO_UPDATE="1"
export BROWSER="Safari"
export EDITOR="vim"
export VISUAL="vim"
export LANG="en_US.UTF-8"
export WHICHMAC="Personal"

# fzf
[ -f ~/.fzf.zsh ] && source "$HOME/.fzf.zsh"
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
# NOTE: At the moment only works for ssh-cloned git repositories
func repo(){
if [ -d .git ]; then
		open -a $BROWSER $(git remote get-url origin | sed 's|.git$||g; s|^git@||g; s|:|/|g; s|^|https://|g')
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

# Default options for less
export LESS='--ignore-case --status-column --LONG-PROMPT --RAW-CONTROL-CHARS --HILITE-UNREAD --tabs=4 --window=-4 --LINE-NUMBERS'

# Colorize man pages
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

# ---------------------------------------- #
#  Cloud tools
# ---------------------------------------- #
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/manojkarthick/bin/google-cloud-sdk/path.zsh.inc' ];
then . '/Users/manojkarthick/bin/google-cloud-sdk/path.zsh.inc';
fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/manojkarthick/bin/google-cloud-sdk/completion.zsh.inc' ];
then . '/Users/manojkarthick/bin/google-cloud-sdk/completion.zsh.inc';
fi



# ---------------------------------------- #
#  Aliases
# ---------------------------------------- #

alias bmadd='echo "$(pwd)" >> $HOME/code/.bookmarks'
alias ignore='function(){ curl -sLw "\n" https://www.gitignore.io/api/$@ ;}'
alias cpwd='pwd|tr -d "\n"|pbcopy'
alias pq='parquet-tools'
alias src="source /Users/$USER/.zshrc"
alias browse="open -a ${DEFAULT_BROWSER}"
alias yt="youtube-dl"

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
#  Kubernetes
# ---------------------------------------- #
# Kubectl Autocomplete
source <(kubectl completion zsh)

# Kube-PS1 prompt customization
source "$HOME/Homebrew/opt/kube-ps1/share/kube-ps1.sh"
function get_cluster_short() {
		echo "$1" | cut -d / -f2
}
export KUBE_PS1_SYMBOL_ENABLE=false
export KUBE_PS1_CLUSTER_FUNCTION=get_cluster_short
export KUBE_PS1_DIVIDER=" : "
export KUBE_PS1_PREFIX="("
export KUBE_PS1_SUFFIX=") "
PROMPT='$(kube_ps1)'$PROMPT


# ---------------------------------------- #
#  SDKMAN
# ---------------------------------------- #
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# ---------------------------------------- #
#  direnv
# ---------------------------------------- #
eval "$(direnv hook zsh)"
