#!/bin/bash

# Script to build Flutter Web on Vercel
# This script clones Flutter, adds it to the PATH, and builds the project.

echo "--- Cloning Flutter SDK ---"
if [ ! -d "flutter" ]; then
  git clone https://github.com/flutter/flutter.git -b stable --depth 1
fi

echo "--- Setting Environment ---"
export PATH="$PATH:$(pwd)/flutter/bin"

echo "--- Initializing Flutter ---"
flutter doctor
flutter config --enable-web

echo "--- Getting Dependencies ---"
flutter pub get

echo "--- Building Web ---"
flutter build web --release --base-href "/"
