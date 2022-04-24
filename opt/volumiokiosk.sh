#!/bin/bash
while true; do timeout 3 bash -c "</dev/tcp/127.0.0.1/3000" >/dev/null 2>&1 && break; done
sed -i 's/"exited_cleanly":false/"exited_cleanly":true/' /data/volumiokiosk/Default/Preferences
sed -i 's/"exit_type":"Crashed"/"exit_type":"None"/' /data/volumiokiosk/Default/Preferences
if [ -L /data/volumiokiosk/SingletonCookie ]; then
  rm -rf /data/volumiokiosk/Singleton*
fi
openbox-session &
while true; do
  /usr/bin/chromium-browser \
    --simulate-outdated-no-au='Tue, 31 Dec 2099 23:59:59 GMT' \
    --force-device-scale-factor=1 \
    --disable-pinch \
    --kiosk \
    --no-first-run \
    --noerrdialogs \
    --disable-3d-apis \
    --disable-breakpad \
    --disable-crash-reporter \
    --disable-infobars \
    --disable-session-crashed-bubble \
    --disable-translate \
    --user-data-dir='/data/volumiokiosk' \
    --app=http://localhost:3000
done
