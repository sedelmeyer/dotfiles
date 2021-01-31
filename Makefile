.PHONY: help dots apt settings conda vscode docker pip cuda1 cuda2 abcde dropbox source macpro zoom

script_dir = scripts

help : ## Show this help. See README.rst for appropriate run order of these commands
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

dots : ## Generate dotfile symlinks in $HOME dir [See: scripts/install_dots.sh]
	bash $(script_dir)/install_dots.sh

apt : ## Install apt packages [See: scripts/install_apt.sh to modify packages]
	bash $(script_dir)/install_apt.sh

settings : ## Configure system settings [See: scripts/install_settings.sh]
	bash $(script_dir)/install_settings.sh

conda : ## Install Miniconda Python and conda [See: scripts/install_conda.sh]
	bash $(script_dir)/install_conda.sh

vscode : ## Install VS Code and extensions [See: scripts/install_vscode.sh]
	bash $(script_dir)/install_vscode.sh

docker : ## Install Docker CE [See: scripts/install_docker.sh]
	bash $(script_dir)/install_docker.sh

pip : ## Install --user Python packages [See: scripts/install_pip.sh]
	bash $(script_dir)/install_pip.sh

cuda1 : ## Configure TensorFlow GPU support (1 of 2) [See: scripts/install_cuda1.sh]
	bash $(script_dir)/install_cuda1.sh

cuda2 : ## Configure TensorFlow GPU support (2 of 2) [See: scripts/install_cuda2.sh]
	bash $(script_dir)/install_cuda1.sh

abcde : ## Install abcde package and dependencies [See: scripts/install_abcde.sh]
	bash $(script_dir)/install_abcde.sh

dropbox: ## Install Dropbox daemon and CLI [See: scripts/install_dropbox.sh]
	bash $(script_dir)/install_dropbox.sh

source: ## Install optional packages from git source [See: scripts/install_source.sh]
	bash $(script_dir)/install_source.sh

macpro: ## Execute fixes for MacBook Pro 5,5 install [See: scripts/install_macpro.sh]
	bash $(script_dir)/install_macpro.sh

zoom: ## Download and install latest version Zoom .deb [See: scripts/install_zoom.sh]
	bash $(script_dir)/install_zoom.sh
