#!/bin/sh

set -eu

FILE="${1:?Naudojimas: $0 file.sql}"
PASSFILE="${PASSFILE:-.passwd}"
DB_PASSFILE="${DB_PASSFILE:-$PASSFILE}"
SSH_USER="${SSH_USER:-masi2289}"
PGHOST="${PGHOST:-pgsql2.mif}"
DB="${DB:-studentu}"

if [ ! -f "$PASSFILE" ]; then
    echo "Nerastas SSH slaptažodžių failas: $PASSFILE" >&2
    echo "Nurodykite jį per PASSFILE=... arba įdėkite .passwd į šį katalogą." >&2
    exit 1
fi

if [ -n "${DB_PASSWORD:-}" ]; then
    db_password="$DB_PASSWORD"
elif [ -n "${PGPASSWORD:-}" ]; then
    db_password="$PGPASSWORD"
elif [ -f "$DB_PASSFILE" ]; then
    db_password=$(head -n 1 "$DB_PASSFILE")
else
    echo "Nerastas PostgreSQL slaptažodis: $DB_PASSFILE" >&2
    echo "Nurodykite DB_PASSFILE=... arba DB_PASSWORD=..." >&2
    exit 1
fi

# Apsaugome slaptažodį, jei jame yra kabučių.
escaped_db_password=$(printf '%s' "$db_password" | sed "s/'/'\\\\''/g")

export PASSFILE SSH_USER PGHOST DB
export REMOTE_CMD="PGPASSWORD='$escaped_db_password' psql -v ON_ERROR_STOP=1 -h '$PGHOST' -d '$DB'"

nix-shell -p sshpass --run \
  'sshpass -f "$PASSFILE" ssh "$SSH_USER@uosis.mif.vu.lt" "$REMOTE_CMD"' \
  < "$FILE"
