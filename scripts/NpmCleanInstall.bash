#!/usr/bin/bash

main()
{
   prepare
   cd -- "${scriptFolderPath}.."
   export NODE_ENV=production
   npm clean-install '--production=false' --strict-peer-deps --prefer-dedupe
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
