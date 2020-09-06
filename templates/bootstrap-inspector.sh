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

# See: https://docs.aws.amazon.com/inspector/latest/userguide/inspector_installing-uninstalling-agents.html

cd /tmp
curl -O https://inspector-agent.amazonaws.com/linux/latest/install
bash install

# TODO: Verify signatore
#See: https://docs.aws.amazon.com/inspector/latest/userguide/inspector_verify-sig-agent-download-linux.html

log 'Finished ...'
