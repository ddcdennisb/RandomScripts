#!/bin/sh

getCountryCode=$(curl https://freegeoip.app/xml/ | xpath /Response/CountryCode)
countryCode=$(echo $getCountryCode | sed 's/<CountryCode>//g' | sed 's/<\/CountryCode>/\'$'\n/g')

echo $countryCode

serialNumber=$( ioreg -c IOPlatformExpertDevice -d 2 | awk -F\" '/IOPlatformSerialNumber/{print $(NF-1)}' )

computerName=$countryCode-$serialNumber

echo $computerName

networksetup -setcomputername "$computerName"
scutil --set LocalHostName "$computerName"
scutil --set HostName "$computerName"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName "$computerName"