#!/usr/bin/env bash

BASEDIR=$(dirname "$0")

cd "$BASEDIR"
../core/tools/run-build-runner.sh

cd "$BASEDIR"
cd ../app/app_main
flutter pub get
flutter packages pub run build_runner build