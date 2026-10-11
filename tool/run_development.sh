#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
flutter run --flavor development -t lib/main_development.dart "$@"
