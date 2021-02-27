# ---------------------------------------- #
#  Nix package manager
# ---------------------------------------- #
if [ -e /Users/manojkarthick/.nix-profile/etc/profile.d/nix.sh ]; then
    . /Users/manojkarthick/.nix-profile/etc/profile.d/nix.sh;
fi

source "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"

# ---------------------------------------- #
# Exports and Paths
# ---------------------------------------- #
# Use Array style path initiation for cleaner look
# Inspired by: https://github.com/BrodieRobertson/dotfiles/blob/master/.zshenv
typeset -U PATH path
path=(
		"$HOME/bin"
		"$HOME/Homebrew/bin"
		"$HOME/Homebrew/opt/gnu-getopt/bin"
		"$HOME/.krew/bin"
		"$HOME/Library/Python/3.8/bin"
		"$HOME/.tfenv/bin"
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
#  starship
# ---------------------------------------- #
eval "$(starship init zsh)"
function starship-disable(){
	starship config "$1.disabled" true
}

function starship-enable(){
	starship config "$1.disabled" false
}


# ---------------------------------------- #
#  Custom
# ---------------------------------------- #

export HOMEBREW_NO_AUTO_UPDATE="1"
export BROWSER="open -a Firefox.app"
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
		starship_precmd
		zle reset-prompt
}
zle -N jump

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

# Start SSH Agent
function start_ssh_agent() {
		eval "$(ssh-agent)"
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

export NVM_DIR="$HOME/.nvm"

# Restic configuration
export RESTIC_PASSWORD_FILE="$HOME/.restic/password"
# ---------------------------------------- #
#  Cloud tools
# ---------------------------------------- #
# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/bin/google-cloud-sdk/path.zsh.inc" ];
then . "$HOME/bin/google-cloud-sdk/path.zsh.inc";
fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/bin/google-cloud-sdk/completion.zsh.inc" ];
then . "$HOME/bin/google-cloud-sdk/completion.zsh.inc";
fi



# ---------------------------------------- #
#  Aliases
# ---------------------------------------- #

alias bmadd='echo "$(pwd)" >> $HOME/code/.bookmarks'
alias ignore='function(){ curl -sLw "\n" https://www.gitignore.io/api/$@ ;}'
alias cpwd='pwd|tr -d "\n"|pbcopy'
alias pq='parquet-tools'
alias src="source $HOME/.zshrc"
alias browse="open -a ${DEFAULT_BROWSER}"
alias yt="youtube-dl"
alias nb="newsboat"
alias findr="open -a Finder.app"
alias vlc="/Applications/VLC.app/Contents/MacOS/VLC"
alias piholeadmin="open -a Safari.app http://pi.hole/admin/"
alias hme="home-manager edit"
alias hms="home-manager switch"
alias hmp="home-manager packages"
alias vgs="vagrant global-status"

# ---------------------------------------- #
#  Bindkeys
# ---------------------------------------- #

bindkey -e
bindkey '\e\e[C' forward-word
bindkey '\e\e[D' backward-word
# Cmd-Left
bindkey "^[[H" beginning-of-line
# Cmd-Right
bindkey "^[[F" end-of-line
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

nvm_lazy() {
		[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
}

# ---------------------------------------- #
#  Kubernetes
# ---------------------------------------- #
# Kubectl Autocomplete
source <(kubectl completion zsh)

# ---------------------------------------- #
#  SDKMAN
# ---------------------------------------- #
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# ---------------------------------------- #
#  direnv
# ---------------------------------------- #
eval "$(direnv hook zsh)"

