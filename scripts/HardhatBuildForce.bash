#!/usr/bin/bash

# Comment-202603132 applies.

main()
{
   prepare
   cd -- "${scriptFolderPath}.."
   export NODE_ENV=production
   npx hardhat build --build-profile production --force
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
