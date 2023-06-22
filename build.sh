#!/bin/bash


echo -n "Enter custom NEXTAUTH_SECRET value - leave blank to auto-generate: "; read NEXTAUTH_SECRET
if [ -z "$NEXTAUTH_SECRET" ]
then
	NEXTAUTH_SECRET=$(openssl rand -base64 32)
	echo "NEXTAUTH_SECRET=$NEXTAUTH_SECRET"
fi

echo -n "Enter custom CALENDSO_ENCRYPTION_KEY value - leave blank to auto-generate: "; read CALENDSO_ENCRYPTION_KEY
if [ -z "$CALENDSO_ENCRYPTION_KEY" ]
then
	CALENDSO_ENCRYPTION_KEY=$(openssl rand -base64 24)
	echo "CALENDSO_ENCRYPTION_KEY=$CALENDSO_ENCRYPTION_KEY"
fi

docker build \
	--build-arg "NEXTAUTH_SECRET=$NEXTAUTH_SECRET" \
	--build-arg "CALENDSO_ENCRYPTION_KEY=$CALENDSO_ENCRYPTION_KEY" \
	-t containers.colpari.dev/colpari-hello/cal.cx .
