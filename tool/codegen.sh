#!/usr/bin/env bash
# CI-friendly code generation. Safe to re-run.
set -euo pipefail
cd "$(dirname "$0")/.."
dart run build_runner build
flutter gen-l10n
