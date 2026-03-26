#!/usr/bin/bash

setErrorHandler()
{
   # The caller was supposed to have already done `set -e`, but it won't hurt to do it again.
   set -e -E

   trap handleError ERR
}

handleError()
{
   set +e
   playErrorSound
   set -e
   exit 1
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
