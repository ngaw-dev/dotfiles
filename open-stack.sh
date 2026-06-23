#!/usr/bin/env bash
#
# open-stack.sh — pick a stack, open its silverstripe.cloud naut dashboard in
# Brave, and open the local project folder in VS Code.
#
# Usage:
#   ./open-stack.sh            # interactive
#   source open-stack.sh       # same, but your shell also ends up cd'd into the
#                              # project folder (plain execution can't change the
#                              # parent shell's directory)

# Root that holds all the local project folders.
ROOT="/Users/amolwankhede/clients/chch-stacks"

# Stacks:  "naut-slug|local-folder"
# naut-slug  -> used in the silverstripe.cloud URL
# local-folder -> folder under $ROOT to open in VS Code
STACKS=(
  "akaroa|akaroa-museum"
  "cccweb|cccweb"
  "cwp|cwp"
  "demo|democcc"
  "district|districtplan"
  "greater|greater-christchurch"
  "ihp|ihp"
  "newsline|newsline"
  "smart|smart"
)

echo "Select a stack:"
i=1
for entry in "${STACKS[@]}"; do
  slug="${entry%%|*}"
  printf "  %2d) %s\n" "$i" "$slug"
  i=$((i + 1))
done

printf "Stack number: "
read -r choice

# Validate selection.
if ! [[ "$choice" =~ ^[0-9]+$ ]] || (( choice < 1 || choice > ${#STACKS[@]} )); then
  echo "Invalid selection." >&2
  return 1 2>/dev/null || exit 1
fi

entry="${STACKS[$((choice - 1))]}"
slug="${entry%%|*}"
folder="${entry##*|}"

# Environment: uat (default) or prod.
printf "Environment [uat/prod] (default uat): "
read -r env
env="${env:-uat}"
case "$env" in
  uat|prod) ;;
  *) echo "Invalid environment '$env'. Use 'uat' or 'prod'." >&2
     return 1 2>/dev/null || exit 1 ;;
esac

url="https://silverstripe.cloud/naut/project/${slug}/environment/${env}/overview"

echo "Opening $slug ($env) -> $url"
open -a "Brave Browser.app" "$url"

# Open the project in VS Code.
project="${ROOT}/${folder}"
if [[ -d "$project" ]]; then
  echo "Opening $project in VS Code"
  code "$project"
  cd "$project" || true
else
  echo "Warning: project folder not found: $project" >&2
fi
