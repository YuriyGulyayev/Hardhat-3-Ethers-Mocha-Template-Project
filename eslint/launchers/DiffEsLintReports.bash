#!/usr/bin/bash

main()
{
   prepare
   cd -- "${scriptFolderPath}../.."
   local -r esLintReportsFolderPath_="eslint/reports/"
   local -r esLintReport1FileName_=EsLintReport1.txt
   local -r esLintReport1FilePath_="${esLintReportsFolderPath_}${esLintReport1FileName_}"
   local -r esLintReport2FileName_=EsLintReport2.txt
   local -r esLintReport2FilePath_="${esLintReportsFolderPath_}${esLintReport2FileName_}"
   # export NODE_ENV=production
   code -nd -- "${esLintReport1FilePath_}" "${esLintReport2FilePath_}"
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
