#!/usr/bin/env bash
# Checks spg.sh against the website's compatibility fixtures.
# password-fixtures.json is a verbatim copy of
# github.com/lucsh/master-password tests/password-fixtures.json.
# Never edit expected values to make this pass. Requires jq.
set -uo pipefail

cd "$(dirname "$0")/.."
command -v jq >/dev/null || { echo 'jq is required' >&2; exit 2; }

pass=0 fail=0
count=$(jq length tests/password-fixtures.json)
for ((i = 0; i < count; i++)); do
  fx=$(jq -c ".[$i]" tests/password-fixtures.json)
  name=$(jq -r .name <<<"$fx")
  seed=$(jq -j .input.seed <<<"$fx")
  master=$(jq -j .input.master <<<"$fx")
  length=$(jq -r .input.length <<<"$fx")
  expected=$(jq -j .expected <<<"$fx")
  args=(-o -s "$seed" -p "$master" -l "$length")
  [[ $(jq -r .input.symbols <<<"$fx") == true ]] || args+=(-e)
  [[ $(jq -r .input.caps <<<"$fx") == true ]] || args+=(-c)

  got=$(./spg.sh "${args[@]}" </dev/null 2>&1)
  if [[ $got == "$expected" ]]; then
    pass=$((pass + 1)); echo "ok    $name"
  else
    fail=$((fail + 1)); echo "FAIL  $name: expected '$expected', got '$got'"
  fi
done

echo "$pass passed, $fail failed"
((fail == 0))
