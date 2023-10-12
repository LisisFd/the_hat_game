#!/usr/bin/env bash

BASEDIR=$(dirname "$0")


cd "$BASEDIR"
flutter pub get
cd ../app/app_main/
./tools/run-build-runner.sh
#--web-renderer html or canvaskit