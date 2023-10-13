#!/bin/bash

password_file=~/passwords.enc
temp_file=$(mktemp)

chmod u=rw,g-rwx,o=-rwx $temp_file

read -sp 'Password: ' password

if [ ! -e $password_file ] || [ ! -s $password_file ]; then
        nano $temp_file && openssl enc -aes-256-cbc -pbkdf2 -pass pass:$password -in $temp_file -out $password_file && rm $temp_file
else
        openssl enc -aes-256-cbc -pbkdf2 -pass pass:$password -d -in $password_file -out $temp_file && nano $temp_file && \
        openssl enc -aes-256-cbc -pbkdf2 -pass pass:$password -in $temp_file -out $password_file && rm $temp_file
fi
