#!/usr/bin/bash

setErrorHandler()
{
   # The caller was supposed to have already done `set -e`, but it won't hurt to do it again.
   set -e -E -o pipefail

   # shopt -s inherit_errexit
   trap handleError ERR
}

handleError()
{
   local -i -r commandExitStatusCode_="${?}"
   set +e
   if (( BASH_SUBSHELL > 0 )) ; then
      set -e
      exit "${commandExitStatusCode_}"
   else
      playErrorSound
      set -e
      exit 4
   fi
}

playSuccessSound()
{
   pw-play /usr/share/sounds/freedesktop/stereo/dialog-information.oga &
}

playWarningSound()
{
   pw-play /usr/share/sounds/freedesktop/stereo/dialog-warning.oga &
}

playErrorSound()
{
   pw-play /usr/share/sounds/Yaru/stereo/dialog-error.oga &
}

setErrorHandler
