#!/usr/bin/bash

setErrorHandler()
{
   set -E
   trap handleError ERR
}

handleError()
{
   pw-play /usr/share/sounds/Yaru/stereo/dialog-error.oga &
   exit 1
}

setErrorHandler
