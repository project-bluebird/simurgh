#!/bin/bash

## Set up environment and install dependecies

if [ -e "environment.yml" ]; then
  # echo "environment.yml file found"
  # Get environment name associated with 'name' variable in file
  ENV=`grep 'name:' environment.yml | tail -n1 | awk '{ print $2}'`


  # Check if you are already in the environment
  if [[ $PATH != *$ENV* ]]; then
    # Check if the environment exists
    conda activate $ENV
    if [ $? -eq 0 ]; then
      :
    else
      # Create the environment and activate
      echo "Conda env '$ENV' doesn't exist."
      echo "Creating '$ENV' environment now .. "

      conda env create -q;

      if [ `uname` == "Linux" ]; then
        # Export path variables for linux
        # Resolves: 'xcb' plugin for OpenGL could not be found
        # https://github.com/TUDelft-CNS-ATM/bluesky/wiki/Installation
        export QT_PLUGIN_PATH="$HOME/miniconda/envs/$ENV/lib/python3.6/site-packages/PyQt5/Qt/plugins/platforms/"
        echo $QT_PLUGIN_PATH
      fi

      conda activate $ENV;

    fi
  fi
fi

## Install Bluesky

BLUESKY_DIR=./bluesky/
BLUEBIRD_DIR=./bluebird/

python $BLUESKY_DIR/check.py
if [ $? -eq 0 ]; then
    printf "Installion of Bluesky dependecies OK.\n"
    printf "Installing Bluesky into Python path..\n"

    ( cd $BLUESKY_DIR; pip install . )

else
    echo FAIL
    exit 1
fi

## Install DoDo

DODO_DIR=./dodo/

( cd $DODO_DIR; pip install Pydodo/ )



