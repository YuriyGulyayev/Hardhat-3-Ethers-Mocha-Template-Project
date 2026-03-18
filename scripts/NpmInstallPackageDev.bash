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
   npm install '--production=false' '--min-release-age=7' --strict-peer-deps --prefer-dedupe --save-dev -- "${1}"
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
