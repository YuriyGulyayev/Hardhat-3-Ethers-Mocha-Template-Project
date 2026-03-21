#!/usr/bin/bash

# [Comment-202603132]
# You rarely need to execute this script because the build is supposed to happen implicitly when needed.
# [/Comment-202603132]

main()
{
   prepare
   cd -- "${scriptFolderPath}.."
   export NODE_ENV=production
   npx hardhat build --build-profile production
   pw-play /usr/share/sounds/freedesktop/stereo/dialog-information.oga &
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
