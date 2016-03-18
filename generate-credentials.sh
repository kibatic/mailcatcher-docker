#!/bin/sh
htpasswd -cb /etc/nginx/htpasswd ${AUTH_USER} ${AUTH_PASSWORD}
unset AUTH_USER
unset AUTH_PASSWORD
