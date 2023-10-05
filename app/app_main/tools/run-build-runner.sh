#!/usr/bin/env bash

BASEDIR=$(dirname "$0")


cd "$BASEDIR"
cd ..
flutter packages pub run build_runner build -c entities --delete-conflicting-outputs
