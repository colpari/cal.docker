#!/bin/bash

set -e

echo -n "Enter custom NEXTAUTH_SECRET value - leave blank to auto-generate: "; read NEXTAUTH_SECRET
if [ -z "$NEXTAUTH_SECRET" ]
then
	NEXTAUTH_SECRET=$(openssl rand -base64 32)
fi

echo -n "Enter custom CALENDSO_ENCRYPTION_KEY value - leave blank to auto-generate: "; read CALENDSO_ENCRYPTION_KEY
if [ -z "$CALENDSO_ENCRYPTION_KEY" ]
then
	CALENDSO_ENCRYPTION_KEY=$(openssl rand -base64 24)
fi

egrep -v 'CALENDSO_ENCRYPTION_KEY|NEXTAUTH_SECRET' .env > .env2
echo "NEXTAUTH_SECRET=$NEXTAUTH_SECRET" >> .env2
echo "CALENDSO_ENCRYPTION_KEY=$CALENDSO_ENCRYPTION_KEY" >> .env2
mv -vf .env2 .env

sudo docker-compose up -d database
set +e
sudo docker-compose build cal

sudo docker-compose down -v

echo "NEXTAUTH_SECRET=$NEXTAUTH_SECRET"
echo "CALENDSO_ENCRYPTION_KEY=$CALENDSO_ENCRYPTION_KEY"

