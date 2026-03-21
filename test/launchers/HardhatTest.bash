#!/usr/bin/bash

main()
{
   prepare
   cd -- "${scriptFolderPath}../.."
   export NODE_ENV=production

   # # Comment-202603194 applies.
   # export MOCHA_IS_PARALLEL=???

   # [Comment-202603175]
   # By default, `network` is `default`. It's in-process.
   # [/Comment-202603175]
   npx hardhat test --build-profile production
   
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
