#!/bin/sh

cd /apps/terraform
terraform init
cd /apps/ansible

exec "$@"
