#!/usr/bin/bash

main()
{
   prepare
   cd -- "${scriptFolderPath}.."
   gio trash --force package-lock.json
   local cutoffDateTime_
   cutoffDateTime_="$( date '--date=14 days ago 00:00:00' --iso-8601=seconds )"
   readonly cutoffDateTime_
   export NODE_ENV=production
   npm install --production=false "--before=${cutoffDateTime_}" --strict-peer-deps --prefer-dedupe
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

main
