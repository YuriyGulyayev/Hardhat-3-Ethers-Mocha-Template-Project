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
   local cutoffDateTime_
   cutoffDateTime_="$( date '--date=7 days ago 00:00:00' --iso-8601=seconds )"
   readonly cutoffDateTime_
   # todo-0 `export NODE_ENV=production` and then `npm --production=false` is questionable.
   # todo-0 Here nd elsewhere allow installing multiple packages at once. So use "${@}" .
   export NODE_ENV=production
   npm install --production=false "--before=${cutoffDateTime_}" --strict-peer-deps --prefer-dedupe --save-dev -- "${1}"
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
