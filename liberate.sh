#!/bin/bash

ln -s /config/ ~/Libation

FILE=/db/LibationContext.db
if [ -f "${FILE}" ]; then
    ln -s $FILE /config/LibationContext.db
fi

/libation/LibationCli scan
/libation/LibationCli liberate