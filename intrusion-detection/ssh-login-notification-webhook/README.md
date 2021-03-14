# Notify on SSH logins

Based on the Telegram notification script from MikeWent (github.com/MikeWent/notify-send-telegram).

## Requirements
- an "Incoming Webhooks" url (from Mattermost, Discord, ...)
- `httpie`

## Setup
Change the `WEBHOOK_URL` to your corresponding value.

Make sure `notify-login.sh` is executable.

Add the following line to `/etc/pam.d/sshd`:
```
session   optional  pam_exec.so type=open_session seteuid <PATH>
```
where `<PATH>` is the path to your `notify-login.sh` script.
