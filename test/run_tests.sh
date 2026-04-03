#!/bin/sh
# Test suite for the ocsigen-i18n generator.
# Each test generates output and compares it to a reference file.

set -e

I18N="$1"
TEST_DIR="$(dirname "$0")"
TSV="$TEST_DIR/example.tsv"
EXPECTED_DIR="$TEST_DIR/expected"
PASS=0
FAIL=0

run_test() {
  name="$1"
  shift
  expected="$EXPECTED_DIR/$name.expected"
  actual=$(mktemp)
  "$I18N" "$@" > "$actual"
  if diff -u "$expected" "$actual" > /dev/null 2>&1; then
    echo "PASS: $name"
    PASS=$((PASS + 1))
  else
    echo "FAIL: $name"
    diff -u "$expected" "$actual" || true
    FAIL=$((FAIL + 1))
  fi
  rm -f "$actual"
}

run_test "default"        --languages en,fr --input-file "$TSV"
run_test "tyxml"          --languages en,fr --input-file "$TSV" --tyxml
run_test "eliom"          --languages en,fr --input-file "$TSV" --eliom
run_test "header"         --languages en,fr --header
run_test "header_eliom"   --languages en,fr --header --eliom
run_test "default_lang"   --languages en,fr --header --default-language fr

echo ""
echo "$PASS passed, $FAIL failed."
[ "$FAIL" -eq 0 ]
