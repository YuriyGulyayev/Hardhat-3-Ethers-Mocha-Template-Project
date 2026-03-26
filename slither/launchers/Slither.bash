#!/usr/bin/bash

main()
{
   prepare
   cd -- "${scriptFolderPath}../.."
   local -r slitherReportsFolderPath_="slither/reports/"
   mkdir --parents -- "${slitherReportsFolderPath_}"
   local -r slitherReport1FileName_=SlitherReport1.txt
   local -r slitherReport1FilePath_="${slitherReportsFolderPath_}${slitherReport1FileName_}"
   local -r slitherReport2FileName_=SlitherReport2.txt
   local -r slitherReport2FilePath_="${slitherReportsFolderPath_}${slitherReport2FileName_}"
   if [[ -f "${slitherReport2FilePath_}" ]] ; then
      gio trash --force -- "${slitherReport1FilePath_}"
      mv --no-clobber -- "${slitherReport2FilePath_}" "${slitherReport1FilePath_}"
   fi
   export NODE_ENV=production
   local slitherExitStatusCode_=0

   # [ToDo-202603173-2]
   # As of Mar 2026, this doesn't work because Slither doesn't support Hardhat 3.
   # Let's hope they will add that support soon.
   # It could be necessary to pass the `--force` flag to Hardhat.
   # Revisit command line arguments. Consider moving most of them to the config file.
   # [/ToDo-202603173-2]
   { ./.venv/bin/slither --compile-custom-build 'npx hardhat build --build-profile production' --filter-paths /node_modules/ --show-ignored-findings --checklist . || slitherExitStatusCode_="${?}" ; } >> "${slitherReport2FilePath_}"

   readonly slitherExitStatusCode_
   if (( slitherExitStatusCode_ == 0 )) ; then
      playSuccessSound
   elif (( slitherExitStatusCode_ == 255 )) ; then
      playWarningSound
   else
      playErrorSound
   fi
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
