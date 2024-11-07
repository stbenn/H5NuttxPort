#!/usr/bin/env bash

## This script is used to locally run a job that gets run when a PR is issued
# Script Usage: source pr_ci_run.sh branch_name job_name > logfile_name.log
# Where branch_name is the branch that will be used for the PR. and job_name is one of the
# arm-## jobs. 

# After the log is done, use pr_ci_log_cleanup.sh on the file to clean up escape characters.

echo Now running NuttX pull request CI testing.

# ## Search for Errors and Warnings
# function find_messages {
#   local tmp_file=/tmp/release-tmp.log
#   local msg_file=/tmp/release-msg.log
#   local pattern='^(.*):(\d+):(\d+):\s+(warning|fatal error|error):\s+(.*)$'
#   grep '^\*\*\*\*\*' $log_file \
#     > $msg_file
#   grep -P "$pattern" $log_file \
#     | uniq \
#     >> $msg_file
#   cat $msg_file $log_file >$tmp_file
#   mv $tmp_file $log_file
# }

branch=$1
job=$2

## Download the Docker Image for NuttX
sudo docker pull \
  ghcr.io/apache/nuttx/apache-nuttx-ci-linux:latest

## Inside the Docker Container:
## Build the Target Group 
sudo docker run -it \
  ghcr.io/apache/nuttx/apache-nuttx-ci-linux:latest \
  /bin/bash -c "
  cd ;
  pwd ;
  git clone https://github.com/stbenn/nuttx --branch $branch ;
  git clone https://github.com/apache/nuttx-apps apps ;
  pushd nuttx ; echo NuttX Source: https://github.com/apache/nuttx/tree/\$(git rev-parse HEAD) ; popd ;
  pushd apps  ; echo NuttX Apps: https://github.com/apache/nuttx-apps/tree/\$(git rev-parse HEAD) ; popd ;
  cd nuttx/tools/ci ;
  (./cibuild.sh -c -A -N -R testlist/$job.dat || echo '***** BUILD FAILED') ;
"

## Free up the Docker disk space
sudo docker system prune --force