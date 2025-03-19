#! /usr/bin/env bash
# This script merges the secrets from the .secrets file into the wwwroot/config-template fileo

# grab the folder of this script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# locate relative files
SECRETS_FILE="$DIR/.secrets"
CONFIG_FILE="$DIR/wwwroot/config.json"

# check if the secrets file exists
if [ ! -f $SECRETS_FILE ]; then
    # nothing to do
    echo "./wwwroot/config.json"  # no output as there is no temp file created
    exit 0
fi

# else

# source the secrets file 
set -a # - and make sure they get 'exposed to the environment by default' (ie without needing export)
.  $SECRETS_FILE
set +a # auto export no longer needed beyond this point

# make a tempfile
TEMP_FILE=$(mktemp /tmp/wwwroot-config-XXXXXX.json)

# read config, use envsubst to replace, redirect output to tempfile
cat $CONFIG_FILE | envsubst > $TEMP_FILE
# return created tempfile as output
echo $TEMP_FILE
exit 0
