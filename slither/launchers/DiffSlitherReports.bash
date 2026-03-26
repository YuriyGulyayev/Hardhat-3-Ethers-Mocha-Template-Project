#!/usr/bin/bash

main()
{
   prepare
   cd -- "${scriptFolderPath}../.."
   local -r slitherReportsFolderPath_="slither/reports/"
   local -r slitherReport1FileName_=SlitherReport1.txt
   local -r slitherReport1FilePath_="${slitherReportsFolderPath_}${slitherReport1FileName_}"
   local -r slitherReport2FileName_=SlitherReport2.txt
   local -r slitherReport2FilePath_="${slitherReportsFolderPath_}${slitherReport2FileName_}"
   # export NODE_ENV=production
   code -nd -- "${slitherReport1FilePath_}" "${slitherReport2FilePath_}"
   playSuccessSound
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
