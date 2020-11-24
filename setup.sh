#!/bin/sh

for d in data logs config plugins; do
	mkdir -pv ./volumes/app/mattermost/${d} || exit
done
chown -vR 2000:2000 ./volumes/app/mattermost || exit

# prepare SSL certificate.
mkdir -pv ./volumes/web/cert || exit

keyfile=./volumes/web/cert/key-no-password.pem
csrfile=./volumes/web/cert/csr.pem
crtfile=./volumes/web/cert/cert.pem

[ -f ${keyfile} ] || openssl genrsa -out ${keyfile} 2048 || exit
[ -f ${csrfile} ] || cat << EOF | openssl req -new -key ${keyfile} -out ${csrfile} || exit
JP
Tokyo







EOF
[ -f ${crtfile} ] || openssl x509 -in ${csrfile} -days 3650 -req -signkey ${keyfile} -out ${crtfile} || exit
