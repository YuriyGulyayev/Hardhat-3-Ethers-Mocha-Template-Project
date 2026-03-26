#!/usr/bin/bash

main()
{
   prepare
   cd -- "${scriptFolderPath}.."
   export NODE_ENV=production
   npm outdated '--production=false' '--min-release-age=7' || (( "${?}" == 1 ))

   # [Comment-202603185/]
   echo $'\n'"Warning. Manually check if any \`github:...\` packages are outdated." 1>&2

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

main
