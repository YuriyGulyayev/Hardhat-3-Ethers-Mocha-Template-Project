#!/usr/bin/bash

main()
{
   prepare
   cd -- "${scriptFolderPath}../.."
   export NODE_ENV=production
   npx hardhat test --build-profile production --network sepolia
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
