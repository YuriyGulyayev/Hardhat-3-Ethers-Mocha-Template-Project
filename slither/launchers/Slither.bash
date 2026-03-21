#!/usr/bin/bash

main()
{
   prepare
   cd -- "${scriptFolderPath}../.."
   export NODE_ENV=production
   local -r slitherOutputFileName_=../Hardhat-3-Ethers-Mocha-Template-Project-Slither-Report.md
   gio trash --force -- "${slitherOutputFileName_}"

   # [ToDo-202603173-2]
   # As of Mar 2026, this doesn't work because Slither doesn't support Hardhat 3.
   # Let's hope they will add that support soon.
   # It could be necessary to pass the `--force` flag to Hardhat.
   # Revisit command line arguments.
   # [/ToDo-202603173-2]
   ./.venv/bin/slither --compile-custom-build 'npx hardhat build --build-profile production' --filter-paths /node_modules/ --show-ignored-findings --checklist . >> "${slitherOutputFileName_}"

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
