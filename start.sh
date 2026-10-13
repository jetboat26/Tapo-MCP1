#!/bin/sh
set -e
SOCK=/var/run/tailscale/tailscaled.sock
mkdir -p /var/run/tailscale /var/lib/tailscale
tailscaled --tun=userspace-networking --statedir=/var/lib/tailscale --socket=$SOCK &
sleep 3
tailscale --socket=$SOCK up --authkey="${TAILSCALE_AUTHKEY:-$TS_AUTHKEY}" --hostname="railway-tapo" $TAILSCALE_EXTRA_ARGS
exec python server.py