#!/usr/bin/bash

main()
{
   prepare
   cd -- "${scriptFolderPath}../.."
   export NODE_ENV=production

   # # Comment-202603194 applies.
   # export MOCHA_IS_PARALLEL=???

   # Comment-202603175 applies.
   npx hardhat test --build-profile production --gas-stats

   pw-play /usr/share/sounds/freedesktop/stereo/dialog-information.oga &
}

prepare()
{
   set -e
   # shopt -s inherit_errexit
   # set -o pipefail
   shopt -s extglob
   declare -g -r scriptFolderPath="${BASH_SOURCE[0]%%+([!/])}"
   # shellcheck source=../../shell-script-libs/ErrorHandling.bash
   source "${scriptFolderPath}../../shell-script-libs/ErrorHandling.bash"
}

main
