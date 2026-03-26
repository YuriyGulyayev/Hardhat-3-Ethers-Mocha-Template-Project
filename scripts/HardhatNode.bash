#!/usr/bin/bash

main()
{
   prepare
   cd -- "${scriptFolderPath}.."
   export NODE_ENV=production
   trap handleSigInt SIGINT
   
   # By default, `network` is `node`.
   npx hardhat node --build-profile production

   # This point is supposed to be unreachable.

   trap - SIGINT
   echo $'\n'"Critical. Bug. Unreachable point 202603258 has been reached." 1>&2
   playErrorSound
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

handleSigInt()
{
   playSuccessSound
   exit 0
}

main
