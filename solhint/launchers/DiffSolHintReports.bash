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
   # export NODE_ENV=production
   code -nd -- "${solHintReport1FilePath_}" "${solHintReport2FilePath_}"
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
