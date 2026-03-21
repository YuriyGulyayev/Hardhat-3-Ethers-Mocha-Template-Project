#!/usr/bin/bash

main()
{
   prepare
   cd -- "${scriptFolderPath}.."
   export NODE_ENV=production
   local -r outputFileName_="../Hardhat-3-Ethers-Mocha-Template-Project-Hardhat-Configuration.json"
   gio trash --force -- "${outputFileName_}"
   npx hardhat run --build-profile production --no-compile --network sepolia scripts/OutputHardhatConfiguration.ts >> "${outputFileName_}"
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
