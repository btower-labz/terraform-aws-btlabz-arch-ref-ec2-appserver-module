#!/usr/bin/env bash

set -o nounset
set -o noclobber
set -o errexit
set -o pipefail

BASENAME=$(basename "$${0}")

function log {
  local MESSAGE=$${1}
  echo "$${BASENAME}: $${MESSAGE}"
  logger --id "$${BASENAME}: $${MESSAGE}"
}

log 'Started ...'

apt-get update --assume-yes
apt-get upgrade --assume-yes
apt-get install --assume-yes nfs-common unzip autofs jq dnsutils hostname mc tcpdump wget screen parted rsync

log 'Finished ...'
