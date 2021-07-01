portupdate:
	port installed > macports/installed.txt
	port installed requested > macports/requested.txt

brewfile:
	cd homebrew; brew bundle dump --force

submodules:
	git submodule update --remote dotbot
