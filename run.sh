#!/bin/bash

set -e

if [ "${AWS_ACCESS_KEY_ID}" = "**None**" ]; then
  echo "You need to set the AWS_ACCESS_KEY_ID environment variable."
  exit 1
fi

if [ "${AWS_SECRET_ACCESS_KEY}" = "**None**" ]; then
  echo "You need to set the AWS_SECRET_ACCESS_KEY environment variable."
  exit 1
fi

if [ "${AWS_BUCKET}" = "**None**" ]; then
  echo "You need to set the AWS_BUCKET environment variable."
  exit 1
fi

if [ "${PREFIX}" = "**None**" ]; then
  echo "You need to set the PREFIX environment variable."
  exit 1
fi

if [ -z "${MYSQL_ENV_MYSQL_USER}" ]; then
  echo "You need to set the MYSQL_ENV_MYSQL_USER environment variable."
  exit 1
fi

if [ -z "${MYSQL_ENV_MYSQL_PASS}" ]; then
  echo "You need to set the MYSQL_ENV_MYSQL_PASS environment variable."
  exit 1
fi

if [ -z "${MYSQL_PORT_3306_TCP_ADDR}" ]; then
  echo "You need to set the MYSQL_PORT_3306_TCP_ADDR environment variable or link to a container named MYSQL."
  exit 1
fi

if [ -z "${MYSQL_PORT_3306_TCP_PORT}" ]; then
  echo "You need to set the MYSQL_PORT_3306_TCP_PORT environment variable or link to a container named MYSQL."
  exit 1
fi

MYSQL_HOST_OPTS="-h $MYSQL_PORT_3306_TCP_ADDR --port $MYSQL_PORT_3306_TCP_PORT -u $MYSQL_ENV_MYSQL_USER -p$MYSQL_ENV_MYSQL_PASS"

echo "Starting dump of ${MYSQLDUMP_DATABASE} to ${MYSQL_PORT_3306_TCP_ADDR}..."

mysqldump $MYSQL_HOST_OPTS $MYSQLDUMP_OPTIONS $MYSQLDUMP_DATABASE | gzip | aws s3 cp - s3://$AWS_BUCKET/$PREFIX/$(date +"%Y")/$(date +"%m")/$(date +"%d").sql.gz || exit 2

echo "Done!"

exit 0
