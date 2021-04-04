#!/bin/bash -e

LONG=xml,binary
OPTS=$(getopt --longoptions $LONG --options "" --name "$(basename "$0")" -- "$@")

eval set -- "$OPTS"

while [[ $# -gt 0 ]]; do
  case "$1" in
  --xml)
    plutil -convert xml1 com.knollsoft.Rectangle.plist

    shift
    ;;
  --binary)
    plutil -convert binary1 com.knollsoft.Rectangle.plist

    shift
    ;;
  *)
    break
    ;;
  esac
done

