#!/bin/bash

GITHUB_TOKEN="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"
OWNER="bhanuraina"
REPO="test_nodejs"
WORKFLOW_FILE="ci.yml"

# Check if workflow dispatch is already running
dispatch_status=$(curl -s -H "Accept: application/vnd.github.v3+json" \
  -H "Authorization: token $github_token" \
  https://api.github.com/repos/$OWNER/$REPO/actions/workflows/$WORKFLOW_FILE/dispatches)
echo $dispatch_status 
if [  $(echo $dispatch_status | jq '.total_count') = 0   ]; then
  echo "Workflow dispatch is already running. Exiting..."
  exit 1
else
  echo "No active workflow dispatch. Proceeding..."
fi

# Add logic to trigger your workflow dispatch or job here
