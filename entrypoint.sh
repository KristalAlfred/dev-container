#!/bin/sh

/gh-auth.sh

# Keep the container running indefinitely
exec tail -f /dev/null

