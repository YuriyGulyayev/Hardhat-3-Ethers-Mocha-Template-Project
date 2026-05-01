#!/usr/bin/bash

main()
{
   prepare
   (( "${#}" == 1 && "${#1}" > 0 ))
   cd -- "${scriptFolderPath}.."
   export NODE_ENV=production
   echo "Checking if the given key already exists in the keystore."

   # todo-3 These prompt for a password twice, right? To be revisited.
   npx hardhat keystore get -- "${1}" || true
   npx hardhat keystore set --force -- "${1}"

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
