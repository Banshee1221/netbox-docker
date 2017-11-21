#!/bin/bash

if [[ -z "${ADMIN_USER}" ]]; then
	echo "ADMIN_USER env not set."
	exit
fi

if [[ -z "${ADMIN_EMAIL}" ]]; then
	echo "ADMIN_EMAIL env not set."
	exit
fi

if [[ -z "${ADMIN_PASS}" ]]; then
	echo "ADMIN_PASS env not set."
	exit
fi

if [[ -z "${ALLOWED_HOSTS}" ]]; then
	echo "ALLOWED_HOSTS env not set."
	exit
fi

if [[ -z "${DB_NAME}" ]]; then
	echo "DB_NAME env not set."
	exit
fi

if [[ -z "${DB_USER}" ]]; then
	echo "DB_USER env not set."
	exit
fi
if [[ -z "${DB_PASS}" ]]; then
	echo "DB_PASS env not set."
	exit
fi
if [[ -z "${DB_HOST}" ]]; then
	echo "DB_HOST env not set."
	exit
fi
if [[ -z "${DB_PORT}" ]]; then
	echo "DB_PORT env not set."
	exit
fi

SECRET=$(python3 /opt/netbox/netbox/generate_secret_key.py)
cd /opt/netbox/netbox

sed -i "s/SECRET_KEY = ''/SECRET_KEY='${SECRET//&/\\&}'/g" netbox/configuration.py

sed -i "s/ALLOWED_HOSTS = \[\]/ALLOWED_HOSTS=\[$ALLOWED_HOSTS\]/g" netbox/configuration.py
sed -i "s/    'NAME': 'netbox',         # Database name/ 'NAME': '$DB_NAME',/g" netbox/configuration.py
sed -i "s/    'USER': '',               # PostgreSQL username/ 'USER': '$DB_USER',/g" netbox/configuration.py
sed -i "s/    'PASSWORD': '',           # PostgreSQL password/ 'PASSWORD': '$DB_PASS',/g" netbox/configuration.py
sed -i "s/    'HOST': 'localhost',      # Database server/ 'HOST': '$DB_HOST',/g" netbox/configuration.py
sed -i "s/    'PORT': '',               # Database port (leave blank for default)/ 'PORT': '$DB_PORT',/g" netbox/configuration.py


python3 manage.py migrate
python3 manage.py collectstatic --no-input

echo "! YOUR SECRET IS: $SECRET"
echo "[+] Adding user: $ADMIN_USER"

echo "from django.contrib.auth.models import User; User.objects.filter(email='$ADMIN_EMAIL').delete(); User.objects.create_superuser('$ADMIN_USER', '$ADMIN_EMAIL', '$ADMIN_PASS')" | python3 manage.py shell

python3 manage.py runserver 0.0.0.0:8000 --insecure
