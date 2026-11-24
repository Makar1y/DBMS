#!/bin/sh

set -eu

cd "$(dirname "$0")"

RUN_SCRIPT="${RUN_SCRIPT:-./run.sh}"

FILES="
sql/01_create_tables.sql
sql/02_create_indexes.sql
sql/03_create_views.sql
sql/04_create_materialized_view.sql
sql/05_create_triggers.sql
sql/06_data.sql
"

for file in $FILES; do
    echo "==> $file" >&2
    "$RUN_SCRIPT" "$file"
done
