#!/bin/sh
set -eu

nix-shell -p sshpass --run \
  'sshpass -f .passwd ssh masi2289@uosis.mif.vu.lt "psql -h pgsql2.mif biblio"' \
  < $1