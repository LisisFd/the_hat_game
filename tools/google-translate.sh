BASEDIR=$(dirname "$0")

cd "$BASEDIR"

cd ..
flutter pub get
flutter packages pub run flutter_arb_translator:main --dir localizations/ --from en --to ru --to uk --service google