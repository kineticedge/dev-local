#!/bin/sh

#
# means to generate a new secret key
#

openssl rand -base64 756  > secret.key
chmod 600 ./secret.key
