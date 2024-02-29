#!/bin/sh
if [ -z "$GITHUB_TOKEN" ]; then
  echo "GITHUB_TOKEN environment variable is not set. Exiting..."
  exit 1
fi

echo "Authenticating with GitHub..."
gh auth login --with-token < "$GITHUB_TOKEN"

