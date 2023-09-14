#!/usr/bin/env bash

BASEDIR=$(dirname "$0")


cd "$BASEDIR"
cd ../app/app_main
flutter pub get
flutter packages pub run build_runner build --delete-conflicting-outputs