#!/bin/bash

umask 077
set -e

password_file=~/passwords.enc
temp_file=$(mktemp)
default_editor=${EDITOR:-nano}

read -sp 'Password: ' password

if [ ! -e $password_file ] || [ ! -s $password_file ]; then
        $default_editor $temp_file && openssl enc -aes-256-cbc -pbkdf2 -pass pass:$password -in $temp_file -out $password_file && rm $temp_file
else
        openssl enc -aes-256-cbc -pbkdf2 -pass pass:$password -d -in $password_file -out $temp_file && $default_editor $temp_file && \
        openssl enc -aes-256-cbc -pbkdf2 -pass pass:$password -in $temp_file -out $password_file && rm $temp_file
fi
