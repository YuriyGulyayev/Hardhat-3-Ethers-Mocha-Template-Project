#!/usr/bin/bash

main()
{
   prepare
   if ! (( "${#}" == 1 && "${#1}" > 0 )) ; then
      echo 'Invalid command line.'
      playErrorSound
      exit
   fi
   cd -- "${scriptFolderPath}.."
   export NODE_ENV=production
   npm install '--production=false' '--min-release-age=7' --strict-peer-deps --prefer-dedupe --save-dev -- "${1}"
   playSuccessSound
}

prepare()
{
   set -e
   # shopt -s inherit_errexit
   # set -o pipefail
   shopt -s extglob
   declare -g -r scriptFolderPath="${BASH_SOURCE[0]%%+([!/])}"
   # shellcheck source=../shell-script-libs/ErrorHandling.bash
   source "${scriptFolderPath}../shell-script-libs/ErrorHandling.bash"
}

main "${@}"
