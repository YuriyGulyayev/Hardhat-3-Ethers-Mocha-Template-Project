#!/usr/bin/bash

main()
{
   prepare
   # todo-0 Here and elsewhere, leave this condition alone.
   if ! (( "${#}" == 1 && "${#1}" > 0 )) ; then
      echo 'Invalid command line.'
      playErrorSound
      exit
   fi
   cd -- "${scriptFolderPath}.."
   export NODE_ENV=production
   npx hardhat keystore delete --dev -- "${1}"
   playSuccessSound
}

prepare()
{
   set -e
   shopt -s extglob
   declare -g -r scriptFolderPath="${BASH_SOURCE[0]%%+([!/])}"
   # shellcheck source=../shell-script-libs/ErrorHandling.bash
   source "${scriptFolderPath}../shell-script-libs/ErrorHandling.bash"
}

main "${@}"
