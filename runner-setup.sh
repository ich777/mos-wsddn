#!/bin/bash
# This shows you how to set up a custom GitHub runner, preferrably in a LXC container.
# Preferred Distribustion: devuan
# Preferred Release: daedalus

# Install base dependencies
apt-get update
apt-get -y install jq wget curl git build-essential cmake

# Create necessary directories and download and extract GitHub Runner
GH_RUNNER_V=2.328.0
mkdir -p /root/runner/mos-wsddn /root/runner_workdir/mos-wsddn
cd /root/runner/mos-wsddn
curl -o actions-runner-linux-x64-${GH_RUNNER_V}.tar.gz -L https://github.com/actions/runner/releases/download/v${GH_RUNNER_V}/actions-runner-linux-x64-${GH_RUNNER_V}.tar.gz
tar xzf ./actions-runner-linux-x64-${GH_RUNNER_V}.tar.gz
rm -f actions-runner-linux-x64-${GH_RUNNER_V}.tar.gz

# Make sure to replace <YOURTOKEN> with the runner token from GitHub
RUNNER_ALLOW_RUNASROOT="1" ./config.sh --url https://github.com/ich777/mos-wsddn --name mos-wsddn --work /root/runner_workdir/mos-wsddn --unattended --token <YOURTOKEN>

# Copy over runner-mos_wsddn to /etc/init.d/ and make sure it's executable
echo "/etc/init.d/runner-mos_wsddn start"  >> /etc/rc.local

# Reboot the LXC container
# Done
