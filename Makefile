.PHONY: help dots apt settings conda vscode docker pip cuda1 cuda2

help : ## Show this help. See README.rst for appropriate run order of these commands
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

dots : ## Generate dotfile symlinks in $HOME dir [See: scripts/install_dots.sh]
	bash scripts/install_dots.sh

apt : ## Install apt packages [See: scripts/install_apt.sh to modify packages]
	bash scripts/install_apt.sh

settings : ## Configure system settings [See: scripts/install_settings.sh]
	bash scripts/install_settings.sh

conda : ## Install Miniconda Python and conda distribution [See: scripts/install_conda.sh]
	bash scripts/install_conda.sh

vscode : ## Install VS Code and extensions [See: scripts/install_vscode.sh]
	bash scripts/install_vscode.sh

docker : ## Install Docker CE [See: scripts/install_docker.sh]
	bash scripts/install_docker.sh

pip : ## Install --user Python packages [See: scripts/install_pip.sh]
	bash scripts/install_pip.sh

cuda1 : ## Configure TensorFlow GPU support (1 of 2) [See: scripts/install_cuda1.sh]
	bash scripts/install_cuda1.sh

cuda2 : ## Configure TensorFlow GPU support (2 of 2) [See: scripts/install_cuda2.sh]
	bash scripts/install_cuda1.sh

