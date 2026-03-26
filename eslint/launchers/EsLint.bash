#!/usr/bin/bash

main()
{
   prepare
   cd -- "${scriptFolderPath}../.."
   local -r esLintReportsFolderPath_="eslint/reports/"
   mkdir --parents -- "${esLintReportsFolderPath_}"
   local -r esLintReport1FileName_=EsLintReport1.txt
   local -r esLintReport1FilePath_="${esLintReportsFolderPath_}${esLintReport1FileName_}"
   local -r esLintReport2FileName_=EsLintReport2.txt
   local -r esLintReport2FilePath_="${esLintReportsFolderPath_}${esLintReport2FileName_}"
   if [[ -f "${esLintReport2FilePath_}" ]] ; then
      gio trash --force -- "${esLintReport1FilePath_}"
      mv --no-clobber -- "${esLintReport2FilePath_}" "${esLintReport1FilePath_}"
   fi
   export NODE_ENV=production
   local esLintExitStatusCode_=0
   npx eslint --no-color "--output-file=${esLintReport2FilePath_}" '--max-warnings=0' . || esLintExitStatusCode_="${?}"
   readonly esLintExitStatusCode_
   if (( esLintExitStatusCode_ == 0 )) ; then
      playSuccessSound
   elif (( esLintExitStatusCode_ == 1 )) ; then
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
