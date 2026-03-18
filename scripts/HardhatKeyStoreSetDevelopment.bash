#!/usr/bin/bash

main()
{
   prepare
   if ! (( "${#}" == 1 && "${#1}" > 0 )) ; then
      echo 'Invalid command line.'
      false
   fi
   cd -- "${scriptFolderPath}.."
   export NODE_ENV=production
   echo "Checking if the given key already exists in the keystore."
   npx hardhat keystore get --dev -- "${1}" || true
   npx hardhat keystore set --dev --force -- "${1}"
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

main "${@}"
