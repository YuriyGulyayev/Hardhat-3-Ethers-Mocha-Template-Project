#!/usr/bin/bash

# This script installs not yet installed and upgrades already installed packages listed in `requirements.txt`
# to their semver-compatible versions.

main()
{
   prepare
   cd -- "${scriptFolderPath}../.."

   # Comment-202605049 applies.
   # ToDo-202605047-2 applies.
   ./.venv/bin/python3 -m pip install --upgrade -r requirements.txt

   playSuccessSound
}

prepare()
{
   set -e
   shopt -s extglob
   declare -g -r scriptFolderPath="${BASH_SOURCE[0]%%+([!/])}"
   # shellcheck source=../../shell-script-libs/ErrorHandling.bash
   source "${scriptFolderPath}../../shell-script-libs/ErrorHandling.bash"
}

main
