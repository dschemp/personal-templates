#!/bin/bash

##
# User Configuration
##

# Change this to your "incoming webhooks" url
WEBHOOK_URL="##CHANGE_ME##"

# Displayed Username of Webhook (must be enabled in your System Console)
INTEGRATION_USERNAME="SSH Login Notifier"

# add your channel here if you want to e. g. inform users instead of writing in channels. Keep this empty to write into the previously defined channel
INTEGRATION_CHANNEL=""

# Color of the info card
INTEGRATION_COLOR="#ffd000"

# Title Text of your info card
INTEGRATION_TEXT="#### :lock: new login detected :exclamation:"

# --- do not change past this line ----------------------------------------------------------------------

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

LOG_USER="$PAM_USER"
LOG_DATE="$( date "+%Y-%m-%d %H:%M:%S" )"
OUT_WHO="$( who )"
LOG_IP="$PAM_RHOST"
LOG_HOST="$(cat /etc/hostname)"

MESSAGE="### :lock: New Login detected :male_detective:

**Host:** $(cat /etc/hostname)
**User:** ${LOG_USER}
**IP:** ${LOG_IP}
**Service:** ${PAM_SERVICE}
**Date:** ${LOG_DATE}
**Uptime:** $(uptime -p)"

JSON_STRING=$( jq -n \
  --arg username "$INTEGRATION_USERNAME" \
  --arg channel "$INTEGRATION_CHANNEL" \
  --arg color "$INTEGRATION_COLOR" \
  --arg text "$INTEGRATION_TEXT" \
  --arg host "$LOG_HOST" \
  --arg user "$LOG_USER" \
  --arg ip "$LOG_IP" \
  --arg service "$PAM_SERVICE" \
  --arg timestamp "$LOG_DATE" \
    '{
      username: $username, channel: $channel,
      attachments: [
        {
          color: $color, text: $text,
          fields: [
            { short: true, title: "Host", value: $host },
            { short: true, title: "User", value: $user },
            { short: true, title: "From IP", value: $ip },
            { short: true, title: "Service", value: $service },
            { short: true, title: "Timestamp", value: $timestamp }
          ]
        }
      ]
    }' )

echo "$JSON_STRING" | http POST $WEBHOOK_URL -j # add parameter "-p HBhb" for debugging
