#!/usr/bin/env bash

BASEDIR=$(dirname "$0")

cd "$BASEDIR"

cd ..

flutter pub get

flutter gen-l10n

dart format app/app_main/lib/localizations/generated/