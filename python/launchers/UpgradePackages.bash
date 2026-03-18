#!/usr/bin/bash

# This script installs not yet installed and upgrades already installed packages listed in `requirements.txt`.

main()
{
   prepare
   cd -- "${scriptFolderPath}../.."
   ./.venv/bin/python3 -m pip install --upgrade -r requirements.txt
   pw-play /usr/share/sounds/freedesktop/stereo/dialog-information.oga &
}

prepare()
{
   set -e
   # shopt -s inherit_errexit
   # set -o pipefail
   shopt -s extglob
   declare -g -r scriptFolderPath="${BASH_SOURCE[0]%%+([!/])}"
}

main
