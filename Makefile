portreclaim:
	sudo port reclaim

portupdate: portreclaim
	port installed > macports/installed.txt
	port installed requested > macports/requested.txt

brewfile:
	cd homebrew; brew bundle dump --force

update: portupdate brewfile

folders:
	mkdir -pv $(HOME)/code
	mkdir -pv $(HOME)/bin
	mkdir -pv $(HOME)/.aws
	mkdir -pv $(HOME)/.newsboat
	mkdir -pv $(HOME)/.antibody
	mkdir -pv $(HOME)/.vim/plugged
	mkdir -pv $(HOME)/.config
	mkdir -pv $(HOME)/.config/starship
	mkdir -pv $(HOME)/.config/nvim
	mkdir -pv $(HOME)/.config/delta
	mkdir -pv $(HOME)/.config/custom
	mkdir -pv $(HOME)/.config/lsd

symlinks: folders
	ln -sfn $(PWD)/config/aws/config $(HOME)/.aws/config
	ln -sfn $(PWD)/config/git/.gitconfig $(HOME)/.gitconfig
	ln -sfn $(PWD)/config/git/.gitignore_global $(HOME)/.gitignore_global
	ln -sfn $(PWD)/config/git/themes.gitconfig $(HOME)/.config/delta/themes.gitconfig
	ln -sfn $(PWD)/config/newsboat/config $(HOME)/.newsboat/config
	ln -sfn $(PWD)/config/newsboat/urls $(HOME)/.newsboat/urls
	ln -sfn $(PWD)/config/vim/.vimrc $(HOME)/.vimrc
	ln -sfn $(PWD)/config/nvim/init.vim $(HOME)/.config/nvim/init.vim
	ln -sfn $(PWD)/config/zsh/.zshrc $(HOME)/.zshrc
	ln -sfn $(PWD)/config/zsh/antibody/.zsh_plugins.txt $(HOME)/.antibody/.zsh_plugins.txt
	ln -sfn $(PWD)/config/zsh/antibody/.zsh_plugins.sh $(HOME)/.antibody/.zsh_plugins.sh
	ln -sfn $(PWD)/config/zsh/antibody/antibody-bundle $(HOME)/bin/antibody-bundle
	ln -sfn $(PWD)/config/zsh/antibody/antibody-install $(HOME)/bin/antibody-install
	ln -sfn $(PWD)/config/starship/starship.toml $(HOME)/.config/starship/starship.toml
	ln -sfn $(PWD)/config/starship/starship-git-disabled.toml $(HOME)/.config/starship/starship-git-disabled.toml
	ln -sfn $(PWD)/config/wget/.wgetrc $(HOME)/.wgetrc
	ln -sfn $(PWD)/config/conda/.condrc $(HOME)/.condarc
	ln -sfn $(PWD)/config/gh/config.yml $(HOME)/.config/gh/config.yml
	ln -sfn $(PWD)/config/bookmarks/.bookmarks $(HOME)/.config/custom/.bookmarks
	ln -sfn $(PWD)/config/timezones/.timezones $(HOME)/.config/custom/.timezones
	ln -sfn $(PWD)/config/lsd/config.yaml $(HOME)/.config/lsd/config.yaml
	ln -sfn $(PWD)/scripts/tz $(HOME)/bin/tz
	ln -sfn $(PWD)/scripts/porthash $(HOME)/bin/porthash
	ln -sfn $(PWD)/scripts/emojicode $(HOME)/bin/emojicode
	ln -sfn $(PWD)/scripts/idea $(HOME)/bin/idea

