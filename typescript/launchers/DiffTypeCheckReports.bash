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
   # export NODE_ENV=production
   code -nd -- "${typeCheckReport1FilePath_}" "${typeCheckReport2FilePath_}"
   playSuccessSound
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
