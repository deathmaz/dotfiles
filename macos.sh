#!/usr/bin/env zsh

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

BACKUP_FILE="${HOME}/Desktop/defaults-backup.$(date '+%Y%m%d_%H%M%S').plist"
echo "Backing up current macOS X defaults to: ${BACKUP_FILE}"
defaults read > "$BACKUP_FILE"

echo
set -x


echo ""
echo ":: setting up macOS system related things"
echo ""

# ------------------
# great references:
# ------------------
# https://github.com/herrbischoff/awesome-osx-command-line
# https://mths.be/macos
# https://juanitofatas.com/mac (catalina specific things)
# https://github.com/blackrobot/dotfiles/blob/master/setup/setup-macos.sh
# ------------------

# Allow apps downloaded from "Anywhere"
sudo spctl --master-disable

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Save screenshots to the desktop
if [ ! -d "$HOME/Desktop/screenshots" ]; then
  mkdir ~/Desktop/screenshots
fi

defaults write com.apple.screencapture location -string "${HOME}/Desktop/screenshots"

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)"
defaults write com.apple.screencapture type -string "png"

# Disable shadow in screenshots"
defaults write com.apple.screencapture disable-shadow -bool true

# no .DS_Store on network
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Increase sound quality for Bluetooth headphones/headsets
# defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40
sudo defaults write bluetoothaudiod "Enable AptX codec" -bool true
sudo defaults write bluetoothaudiod "Enable AAC codec" -bool true

# Open App from 3rd-party developer
# defaults write /Library/Preferences/com.apple.security GKAutoRearm -bool NO

# mojave sub-pixel font smoothing
# ref: https://www.reddit.com/r/MacOS/comments/9ijy88/font_antialiasing_on_mojave/e6mbs49/
# ref: https://forums.macrumors.com/threads/the-subpixel-aa-debacle-and-font-rendering.2184484/
defaults -currentHost write -globalDomain AppleFontSmoothing -int 2
defaults write -g CGFontRenderingFontSmoothingDisabled -bool false
# ^-- or, `NO`, instead of `false`

# show all hidden files and folders (or is it `true`?)
defaults write com.apple.Finder AppleShowAllFiles YES

# Enable Tab in modal dialogs.
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Set Menu Bar Clock Output Format
sudo defaults write com.apple.menuextra.clock DateFormat -string "EEE d MMM HH:mm"

##
# Finder
##

# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Show the ~/Library folder
chflags nohidden ~/Library

# Show the /Volumes folder
sudo chflags nohidden /Volumes

##
# Safari
##

# Privacy: don’t send search queries to Apple
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

# Show the full URL in the address bar (note: this still hides the scheme)
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# Prevent Safari from opening ‘safe’ files automatically after downloading
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# Hide Safari’s bookmarks bar by default
defaults write com.apple.Safari ShowFavoritesBar -bool false

# Enable the Develop menu and the Web Inspector in Safari
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

# Add a context menu item for showing the Web Inspector in web views
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

# Enable continuous spellchecking
defaults write com.apple.Safari WebContinuousSpellCheckingEnabled -bool true

# Warn about fraudulent websites
defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool true

# Block pop-up windows
defaults write com.apple.Safari WebKitJavaScriptCanOpenWindowsAutomatically -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptCanOpenWindowsAutomatically -bool false

##
# Activity Monitor
##

# Show the main window when launching Activity Monitor
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# Visualize CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor IconType -int 5

# Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Sort Activity Monitor results by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

##
# Text Edit
##

# Use plain text mode for new TextEdit documents
defaults write com.apple.TextEdit RichText -int 0
# Open and save files as UTF-8 in TextEdit
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

##
# Photos
##

# Prevent Photos from opening automatically when devices are plugged in
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

set +x
echo

function app_is_running {
  osascript -so -e "application \"$1\" is running"
}

function ask {
  local app compcontext question reply

  app="$1"
  compcontext='yn:yes or no:(y n)'
  question="%BShould ${app} be quit right now?%b"

  while true ; do
    vared -e -p "${question} (y/n or <ctrl-c>) " reply
    case "$reply" in
      (Y* | y*) return 0 ;;
      (N* | n*) return 1 ;;
    esac
  done
}

apps_to_restart=(
  "Activity Monitor"
  "Address Book"
  "Calendar"
  "cfprefsd"
  "Contacts"
  "Dock"
  "Finder"
  "Google Chrome"
  "Photos"
  "Safari"
  "SystemUIServer"
  "Terminal"
)

for app in "${apps_to_restart[@]}"; do
  if [[ "$(app_is_running "${app}")" == "true" ]]; then
    echo "\"${app}\" needs to be restarted."

    if ( ask "${app}" ); then
      echo "Quitting ${app}"
      killall "${app}" &> /dev/null
    else
      echo "Leaving ${app} open"
    fi

    echo
  fi
done

echo "Done. Note that some of these changes require a logout/restart to take effect."
