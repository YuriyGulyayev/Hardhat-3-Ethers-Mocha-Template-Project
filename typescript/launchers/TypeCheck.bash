#!/usr/bin/bash

main()
{
   prepare
   cd -- "${scriptFolderPath}../.."
   local -r typeCheckReportsFolderPath_="typescript/reports/"
   local -r typeCheckReport1FileName_=TypeCheckReport1.txt
   local -r typeCheckReport1FilePath_="${typeCheckReportsFolderPath_}${typeCheckReport1FileName_}"
   local -r typeCheckReport2FileName_=TypeCheckReport2.txt
   local -r typeCheckReport2FilePath_="${typeCheckReportsFolderPath_}${typeCheckReport2FileName_}"
   if [[ -f "${typeCheckReport2FilePath_}" ]] ; then
      gio trash --force -- "${typeCheckReport1FilePath_}"
      mv --no-clobber -- "${typeCheckReport2FilePath_}" "${typeCheckReport1FilePath_}"
   else
      mkdir --parents -- "${typeCheckReportsFolderPath_}"
   fi
   # export NODE_ENV=production
   local -i tscExitStatusCode_=0
   { npx tsc --noEmit || tscExitStatusCode_="${?}" ; } &>> "${typeCheckReport2FilePath_}"
   readonly tscExitStatusCode_
   if (( tscExitStatusCode_ == 0 )) ; then
      playSuccessSound
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
