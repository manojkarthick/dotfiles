# ---------------------------------------- #
# Exports and Paths
# ---------------------------------------- #
# Use Array style path initiation for cleaner look
# Inspired by: https://github.com/BrodieRobertson/dotfiles/blob/master/.zshenv
typeset -U PATH path
path=(
		"$HOME/bin"								# user binaries
		"/opt/local/bin"						# macports binaries
		"/opt/local/sbin"						# macports system binaries
		"$HOME/Homebrew/bin"					# homebrew binaries
		"$HOME/Homebrew/opt/gnu-getopt/bin"		# todo: replace this.
		"$HOME/.krew/bin"						# kubectl krew plugin manager
		"$HOME/Library/Python/3.8/bin"			# default python. todo: remove this.
		"$HOME/.tfenv/bin"						# manage terraform versions
		"$path[@]"
)
export PATH

# ---------------------------------------- #
#  Antibody
# ---------------------------------------- #
# Automatically load compinit only once per day
# Inspired by: https://gist.github.com/ctechols/ca1035271ad134841284

# use menu style tab selections
zstyle ':completion:*' menu select

autoload -Uz compinit
if [ $(date +'%j') != $(stat -f '%Sm' -t '%j' ~/.zcompdump) ]; then
		compinit
else
		compinit -C
fi

source "$HOME/.antibody/.zsh_plugins.sh"

# ---------------------------------------- #
#  cargo
# ---------------------------------------- #
source "$HOME/.cargo/env"

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
export HOMEBREW_NO_ANALYTICS="1"
export EDITOR="vim"
export VISUAL="vim"
export LANG="en_US.UTF-8"
export WHICHMAC="Personal"
export DELTA_PAGER="less -R"

# fzf with Jellybeans color scheme: https://github.com/junegunn/fzf/wiki/Color-schemes#jellybeans
[ -f /opt/local/share/fzf/shell/key-bindings.zsh ] && source "/opt/local/share/fzf/shell/key-bindings.zsh"
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
export FZF_CTRL_T_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
export FZF_DEFAULT_OPTS='--height 40% 
--layout=reverse
--color fg:188,bg:233,hl:103,fg+:222,bg+:234,hl+:104
--color info:183,prompt:110,spinner:107,pointer:167,marker:215
'

# Online cheatsheet
function cheat(){
		curl "cheat.sh/$1"
}

# Jump to project bookmark
jump() {
		local dir
		dir=$(cat ~/.config/custom/.bookmarks| fzf ) &&
				cd "$dir"
						starship_precmd
						zle reset-prompt
				}
		zle -N jump

# Staging files for git using fzf
# Inspired by: https://bluz71.github.io/2018/11/26/fuzzy-finding-in-bash-with-fzf.html
fzf_git_add() {
		local selections=$(
		git status --porcelain | \
				fzf --ansi --multi \
				--preview 'if (git ls-files --error-unmatch {2} &>/dev/null); then
						git diff --color=always {2}
				else
						bat --color=always --line-range :500 {2}
						fi'
				)
				if [[ -n $selections ]]; then
						git add --verbose $(echo "$selections" | cut -c 4- | tr '\n' ' ')
				fi
		}

alias gadd='fzf_git_add'

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
alias src="source $HOME/.zshrc"
alias browse="open -a ${DEFAULT_BROWSER}"
alias yt="youtube-dl"
alias nb="newsboat"
alias findr="open -a Finder.app"
alias vlc="/Applications/VLC.app/Contents/MacOS/VLC"
alias piholeadmin="open -a Safari.app http://pi.hole/admin/"
alias vgs="vagrant global-status"
alias sz="stat -f%z"
[ -f ~/.kubectl_aliases ] && source ~/.kubectl_aliases

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
# Sysutils                                 #
# ---------------------------------------- #

# RAM functions sourced from: https://github.com/paulmillr/dotfiles/blob/master/home/.zshrc.sh
function _calcram() {
		local sum
		sum=0
		for i in `ps aux | grep -i "$1" | grep -v "grep" | awk '{print $6}'`; do
				sum=$(($i + $sum))
		done
		sum=$(echo "scale=2; $sum / 1024.0" | bc)
		echo $sum
}

# Show how much RAM application uses.
# $ ram safari
# # => safari uses 154.69 MBs of RAM
function ram() {
		local sum
		local app="$1"
		if [ -z "$app" ]; then
				echo "First argument - pattern to grep from processes"
				return 0
		fi

		sum=$(_calcram $app)
		if [[ $sum != "0" ]]; then
				echo "${fg[blue]}${app}${reset_color} uses ${fg[green]}${sum}${reset_color} MBs of RAM"
		else
				echo "No active processes matching pattern '${fg[blue]}${app}${reset_color}'"
		fi
}

# Same, but tracks RAM usage in realtime. Will run until you stop it.
# $ rams safari
function rams() {
		local sum
		local app="$1"
		if [ -z "$app" ]; then
				echo "First argument - pattern to grep from processes"
				return 0
		fi

		while true; do
				sum=$(_calcram $app)
				if [[ $sum != "0" ]]; then
						echo -en "${fg[blue]}${app}${reset_color} uses ${fg[green]}${sum}${reset_color} MBs of RAM\r"
				else
						echo -en "No active processes matching pattern '${fg[blue]}${app}${reset_color}'\r"
				fi
				sleep 1
		done
}

# ---------------------------------------- #
#  Language version managers
# ---------------------------------------- #

# NOTE: pyenv and goenv are lazy-loaded in the below commands
# The reason the behavior has been changed is to reduce shell startup latency
# Inspired by: https://carlosbecker.com/posts/speeding-up-zsh/

# Python
pyenv() {
		eval "$(command pyenv init - zsh --no-rehash)"
		pyenv "$@"
}

# Golang
export GOENV_ROOT="$HOME/.goenv"
export PATH="${GOENV_ROOT}/bin:$PATH"
goenv() {
		eval "$(command goenv init - zsh)"
		goenv "$@"
}

# Node.js
export NVM_DIR="$HOME/.nvm"
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

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('$HOME/miniconda/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
		eval "$__conda_setup"
else
		if [ -f "$HOME/miniconda/etc/profile.d/conda.sh" ]; then
				. "$HOME/miniconda/etc/profile.d/conda.sh"
		else
				export PATH="$HOME/miniconda/bin:$PATH"
		fi
fi
unset __conda_setup
# <<< conda initialize <<<


