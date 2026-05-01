#!/usr/bin/bash

# This script creates a Python virtual environment.
# It trashes any already existing one beforehand.

main()
{
   prepare
   cd -- "${scriptFolderPath}../.."
   gio trash --force -- .venv
   python3 -m venv .venv
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
