#!/bin/bash
# Usage: ./send.sh <webhook_url> <json_file_path>

WEBHOOK_URL="$1"
JSON_FILE="$2"

if [ -z "$WEBHOOK_URL" ] || [ -z "$JSON_FILE" ]; then
  echo "Usage: $0 <webhook_url> <json_file_path>"
  exit 1
fi

if [ ! -f "$JSON_FILE" ]; then
  echo "Error: JSON file not found at $JSON_FILE"
  exit 1
fi

# Send to Discord
# -s: Silent (no progress bar)
# -S: Show error if fails
# -o /dev/null: Discard output (unless error)
# -w "%{http_code}": Print HTTP status code
HTTP_CODE=$(curl -s -S -o /dev/null -w "%{http_code}" -H "Content-Type: application/json" -d @"$JSON_FILE" "$WEBHOOK_URL")

if [ "$HTTP_CODE" -eq 204 ] || [ "$HTTP_CODE" -eq 200 ]; then
  echo "Success: Sent to Discord (HTTP $HTTP_CODE)"
  exit 0
else
  echo "Error: Failed to send to Discord (HTTP $HTTP_CODE)"
  # Print response body for debugging
  curl -s -H "Content-Type: application/json" -d @"$JSON_FILE" "$WEBHOOK_URL"
  exit 1
fi
