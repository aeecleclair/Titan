#!/bin/sh

# This script extracts the Dart defines passed from Flutter and creates an
# Xcode configuration file `Dart-Defines.xcconfig` which variables will
# be accessible during the xcode compilation steps.
# Based on https://medium.com/@mahdi.yami3235/mastering-native-configurations-in-flutter-the-power-of-dart-define-10f2b89922dc

SRCROOT="${SRCROOT:-$(pwd)}"

OUTPUT_FILE="${SRCROOT}/Flutter/Dart-Defines.xcconfig"
: > $OUTPUT_FILE

function decode_url() { echo "${*}" | base64 --decode; }

IFS=',' read -r -a define_items <<<"$DART_DEFINES"

for index in "${!define_items[@]}"
do
    item=$(decode_url "${define_items[$index]}")

    lowercase_item=$(echo "$item" | tr '[:upper:]' '[:lower:]')
    if [[ $lowercase_item != flutter* ]]; then
        echo "$item" >> "$OUTPUT_FILE"
    fi
done