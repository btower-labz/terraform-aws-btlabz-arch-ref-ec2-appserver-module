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

# See: https://docs.aws.amazon.com/codedeploy/latest/userguide/codedeploy-agent-operations-install-linux.html
# See: https://docs.aws.amazon.com/codedeploy/latest/userguide/resource-kit.html#resource-kit-bucket-names

yum -y update
yum -y install ruby

cd /tmp

# TODO: hardcode
wget https://aws-codedeploy-me-south-1.s3.me-south-1.amazonaws.com/latest/install
chmod +x ./install
./install auto

# See: https://github.com/aws/aws-codedeploy-agent/issues/205
chmod -x /usr/lib/systemd/system/codedeploy-agent.service

service codedeploy-agent start
codedeploy-agent status

log 'Finished ...'
