#!/usr/bin/bash

# This script lists already installed packages, which newer versions are available.
# It does not take `requirements.txt` into account.

main()
{
   prepare
   cd -- "${scriptFolderPath}../.."

   # [Comment-202605049]
   # Issue. Currently using PIP. Its capabilities are limited. It does not support a package lock file.
   # Consider using Poetry instead.
   # [/Comment-202605049]
   # [ToDo-202605047-2]
   # Use PIP 26+.
   # Calculate the `cutoffDateTime_` variable, like other scripts. do
   # Add this to `pip` invocation:
   # --uploaded-prior-to "${cutoffDateTime_}"
   # [/ToDo-202605047-2]
   ./.venv/bin/python3 -m pip list --outdated

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
