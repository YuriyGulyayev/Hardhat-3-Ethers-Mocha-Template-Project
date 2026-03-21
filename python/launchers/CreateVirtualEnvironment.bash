#!/usr/bin/bash

# This script creates a Python virtual environmnt.
# Execute this script once.
# Remember to execute it after cloning the repository.

main()
{
   prepare
   cd -- "${scriptFolderPath}../.."
   python3 -m venv .venv
   pw-play /usr/share/sounds/freedesktop/stereo/dialog-information.oga &
}

prepare()
{
   set -e
   # shopt -s inherit_errexit
   # set -o pipefail
   shopt -s extglob
   declare -g -r scriptFolderPath="${BASH_SOURCE[0]%%+([!/])}"
   # shellcheck source=../../shell-script-libs/ErrorHandling.bash
   source "${scriptFolderPath}../../shell-script-libs/ErrorHandling.bash"
}

main
