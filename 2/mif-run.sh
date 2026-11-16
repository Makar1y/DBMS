#!/bin/sh

set -eu

FILE="${1:?Naudojimas: $0 file.sql}"
DB_PASSFILE="${DB_PASSFILE:-.passwd}"
PGHOST="${PGHOST:-pgsql2.mif}"
DB="${DB:-studentu}"

if [ -n "${DB_PASSWORD:-}" ]; then
    PGPASSWORD="$DB_PASSWORD" psql -v ON_ERROR_STOP=1 -h "$PGHOST" -d "$DB" < "$FILE"
elif [ -n "${PGPASSWORD:-}" ]; then
    psql -v ON_ERROR_STOP=1 -h "$PGHOST" -d "$DB" < "$FILE"
elif [ -f "$DB_PASSFILE" ]; then
    PGPASSWORD=$(head -n 1 "$DB_PASSFILE") psql -v ON_ERROR_STOP=1 -h "$PGHOST" -d "$DB" < "$FILE"
else
    echo "Nerastas PostgreSQL slaptažodis: $DB_PASSFILE" >&2
    echo "Nurodykite DB_PASSFILE=... arba DB_PASSWORD=..., arba naudokite ~/.pgpass." >&2
    exit 1
fi
