#!/usr/bin/env bash

BASEDIR=$(dirname "$0")
cd "$BASEDIR"
cd ../
flutter clean
flutter pub upgrade
flutter pub get
