#!/bin/bash

# Credit to https://github.com/yiannosch

####-- (Cosmetic) Colour output --####
RED="\033[01;31m"      # Issues/Errors
GREEN="\033[01;32m"    # Success
YELLOW="\033[01;33m"   # Warnings/Information
BLUE="\033[01;34m"     # Heading
BOLD="\033[01;01m"     # Highlight
RESET="\033[00m"       # Normal

# Start Firefox for first time, background process
firefox-esr &
sleep 3s                    # Add delay to make sure that the FF profile has been created
#--- Configure firefox
echo -e "\n ${BLUE}[*]${RESET} Installing useful${BLUE}Firefox${RESET} addons"

#--- Download extensions
ffpath="$(find ~/.mozilla/firefox/*.default*/ -maxdepth 0 -mindepth 0 -type d -name '*.default*' -print -quit)/extensions"
[ "${ffpath}" == "/extensions" ] && echo -e  "${RED}[!]${RESET} Couldn't find Firefox's config folder" 1>&2
mkdir -p "${ffpath}/"

# Wappalyzer
echo -e " ${YELLOW}[i]${RESET} Downloading ${YELLOW}${BOLD}Wappalyzer${RESET}"
timeout 300 curl --progress -k -L -f "https://addons.mozilla.org/firefox/downloads/file/3204419/wappalyzer-5.8.4-fx.xpi?src=dp-btn-primary" -o "$ffpath/wappalyzer@crunchlabz.com.xpi" || echo -e " ${RED}[!]${RESET} Issue downloading ${BOLD}Wappalyzer${RESET}" 1>&2
# Foxyproxy standard
echo -e " ${YELLOW}[i]${RESET} Downloading ${YELLOW}${BOLD}FoxyProxy standard${RESET}"
timeout 300 curl --progress -k -L -f "https://addons.mozilla.org/firefox/downloads/file/3348763/foxyproxy_standard-6.6.2-an+fx.xpi?src=dp-btn-primary" -o "$ffpath/foxyproxy@eric.h.jung.xpi" || echo -e " ${RED}[!]${RESET} Issue downloading ${BOLD}FoxyProxy standard${RESET}" 1>&2
# Cookies and headers analyser
echo -e " ${YELLOW}[i]${RESET} Downloading ${YELLOW}${BOLD}Cookies and headers analyser${RESET}"
timeout 300 curl --progress -k -L -f "https://addons.mozilla.org/firefox/downloads/file/858683/cookies_and_http_headers_analyser-2.6-an+fx-windows.xpi?src=dp-btn-primary" -o "$ffpath/{637ac5a9-47b3-475b-b724-f455f5a56897}.xpi" || echo -e " ${RED}[!]${RESET} Issue downloading ${BOLD}Cookies and HTTP headers analyser${RESET}" 1>&2
# Web developer toolbar
echo -e " ${YELLOW}[i]${RESET} Downloading ${YELLOW}${BOLD}Web developer toolbar${RESET}"
timeout 300 curl --progress -k -L -f "https://addons.mozilla.org/firefox/downloads/file/773845/web_developer-2.0.1-an+fx.xpi?src=dp-btn-primary" -o "$ffpath/{c45c406e-ab73-11d8-be73-000a95be3b12}.xpi" || echo -e " ${RED}[!]${RESET} Issue downloading ${BOLD}Web developer toolbar${RESET}" 1>&2
# Cookie editor
echo -e " ${YELLOW}[i]${RESET} Downloading ${YELLOW}${BOLD}Cookie editor${RESET}"
timeout 300 curl --progress -k -L -f "https://addons.mozilla.org/firefox/downloads/file/1132754/cookie_editor-0.1.3.1-an+fx.xpi?src=dp-btn-primary" -o "$ffpath/{48df221a-8316-4d17-9191-7fc5ea5f14c0}.xpi" || echo -e " ${RED}[!]${RESET} Issue downloading ${BOLD}Cookie editor${RESET}" 1>&2
# React developer tools
echo -e " ${YELLOW}[i]${RESET} Downloading ${YELLOW}${BOLD}React developer tools${RESET}"
timeout 300 curl --progress -k -L -f "https://addons.mozilla.org/firefox/downloads/file/1209034/react_developer_tools-4.1.0-fx.xpi?src=dp-btn-primary" -o "$ffpath/@react-devtools.xpi" || echo -e " ${RED}[!]${RESET} Issue downloading ${BOLD}React developer tools${RESET}" 1>&2

#--- Installing extensions
for FILE in $(find "${ffpath}" -maxdepth 1 -type f -name '*.xpi'); do
  d="$(basename "$FILE" .xpi)"
  mkdir -p "${ffpath}/${d}/"
  unzip -q -o -d "${ffpath}/${d}/" "$FILE"
  rm -f "$FILE"
done

#Generate random key to use for foxyproxy configuration
function random_key() {
 od -A n -t u -N 4 /dev/urandom
}


# Kill firefox processes gracefully!
kill -s SIGTERM $(ps -e | grep firefox-esr | awk '{print $1}')
sleep 3s

#Enable plugins
FILE=$(find ~/.mozilla/firefox/*.default*/ -maxdepth 1 -type f -name 'extensions.json' -print -quit)
if [ ! -e "$FILE" ] || [ -z "$FILE" ]; then
  echo -e " ${RED}[!]${RESET}${BOLD} extensions.js${RESET} not found! "
else
  echo -e " ${GREEN}[+]${RESET} Enabled ${GREEN}Firefox's extensions${RESET} "
  sed -i 's/"active":false,/"active":true,/g' "$FILE"                # Force them all!
  sed -i 's/"userDisabled":true,/"userDisabled":false,/g' "$FILE"    # Force them all!
fi

# Enable addons. Firefox must be closed.
FILE=$(find ~/.mozilla/firefox/*.default*/ -maxdepth 1 -type f -name 'prefs.js' -print -quit)
if [ ! -e "$FILE" ] || [ -z "$FILE" ]; then
  echo -e " ${RED}[!]${RESET}${BOLD} prefs.js${RESET} not found! "
else
  echo 'user_pref("extensions.autoDisableScopes", 14);' >> "$FILE"
fi

# Restarting Firfox
echo -e " ${YELLOW}[i]${RESET} Restarting Firefox..."
timeout 8 firefox >/dev/null 2>&1
sleep 3s

