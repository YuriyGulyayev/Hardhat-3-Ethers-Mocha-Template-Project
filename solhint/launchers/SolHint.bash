#!/usr/bin/bash

main()
{
   prepare
   cd -- "${scriptFolderPath}../.."
   local -r solHintReportsFolderPath_="solhint/reports/"
   local -r solHintReport1FileName_=SolHintReport1.txt
   local -r solHintReport1FilePath_="${solHintReportsFolderPath_}${solHintReport1FileName_}"
   local -r solHintReport2FileName_=SolHintReport2.txt
   local -r solHintReport2FilePath_="${solHintReportsFolderPath_}${solHintReport2FileName_}"
   if [[ -f "${solHintReport2FilePath_}" ]] ; then
      gio trash --force -- "${solHintReport1FilePath_}"
      mv --no-clobber -- "${solHintReport2FilePath_}" "${solHintReport1FilePath_}"
   else
      mkdir --parents -- "${solHintReportsFolderPath_}"
   fi
   export NODE_ENV=production
   local -i solHintExitStatusCode_=0
   { npx solhint --noPoster --disc --max-warnings=0 'contracts/**/*.sol' || solHintExitStatusCode_="${?}" ; } &>> "${solHintReport2FilePath_}"
   readonly solHintExitStatusCode_
   if (( solHintExitStatusCode_ == 0 )) ; then
      playSuccessSound
   elif (( solHintExitStatusCode_ == 1 )) ; then
      playWarningSound
   else
      playErrorSound
   fi
}

prepare()
{
   set -e
   shopt -s extglob
   declare -g -r scriptFolderPath="${BASH_SOURCE[0]%%+([!/])}"
   # shellcheck source=../../shell-script-libs/ErrorHandling.bash
   source "${scriptFolderPath}../../shell-script-libs/ErrorHandling.bash"
}

main
