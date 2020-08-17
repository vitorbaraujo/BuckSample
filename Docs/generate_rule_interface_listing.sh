#!/usr/bin/env bash

set -o errexit # fail if any command fails
set -o pipefail
set -o nounset

cd "$(dirname "$0")" || exit # Run from the directory of this script

RULETYPE_FILE=all_ruletypes.py
BUCK=$(command -v buck)

echo "Generating all ruletype interfaces from local version of Buck: ${BUCK}"

echo "# Generated by $(id -F)" > "${RULETYPE_FILE}"
echo "# To re-generate run:" > "${RULETYPE_FILE}"
echo "#    ./generate_ruletype_docs.sh" > "${RULETYPE_FILE}"
echo "# Buck version: $($BUCK --version)" > "${RULETYPE_FILE}"

ruletypes=($(buck audit ruletypes)) # Array of ruletypes

for r in "${ruletypes[@]}"
do
	echo "Ruletype: $r "
    "$BUCK" audit ruletype "${r}" >> "${RULETYPE_FILE}"
done
