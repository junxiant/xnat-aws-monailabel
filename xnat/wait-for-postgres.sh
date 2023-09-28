#!/bin/sh
# wait-for-postgres.sh

set -e

/usr/local/bin/make-xnat-config.sh

cmd="$@"

export PGPASSWORD="$XNAT_DATASOURCE_PASSWORD"
until psql -U "$XNAT_DATASOURCE_USERNAME" -h "$XNAT_DATASOURCE_ENDPOINT" -d "xnat" -c '\q'; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 5
done

# Plugins
wget https://bitbucket.org/icrimaginginformatics/ohif-viewer-xnat-plugin/downloads/ohif-viewer-3.6.0-RC-1.jar -P /data/xnat/home/plugins/

>&2 echo "Postgres is up - executing command \"$cmd\""
exec $cmd