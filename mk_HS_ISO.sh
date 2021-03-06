#!/bin/sh

hdiutil attach /Applications/Install\ macOS\ High\ Sierra.app/Contents/SharedSupport/InstallESD.dmg -noverify -mountpoint /Volumes/HS

hdiutil create -o ./HSBase.cdr -size 7316m -layout SPUD -fs HFS+J

hdiutil attach ./HSBase.cdr.dmg -noverify -mountpoint /Volumes/install_build

asr restore -source /Applications/Install\ macOS\ High\ Sierra.app/Contents/SharedSupport/BaseSystem.dmg -target /Volumes/install_build -noprompt -noverify -erase

rm -rf /Volumes/OS\ X\ Base\ System/System/Installation/Packages

mkdir -p /Volumes/OS\ X\ Base\ System/System/Installation/Packages

cp -R /Volumes/HS/Packages/* /Volumes/OS\ X\ Base\ System/System/Installation/Packages/

hdiutil detach /Volumes/OS\ X\ Base\ System/

hdiutil detach /Volumes/HS/

mv ./HSBase.cdr.dmg ./BaseSystem.dmg

# Restore the 10.13 Installer's BaseSystem.dmg into file system and place custom BaseSystem.dmg into the root

hdiutil create -o ./HS.cdr -size 8965m -layout SPUD -fs HFS+J

hdiutil attach ./HS.cdr.dmg -noverify -mountpoint /Volumes/install_build

asr restore -source /Applications/Install\ macOS\ High\ Sierra.app/Contents/SharedSupport/BaseSystem.dmg -target /Volumes/install_build -noprompt -noverify -erase

cp ./BaseSystem.dmg /Volumes/OS\ X\ Base\ System

hdiutil detach /Volumes/OS\ X\ Base\ System/

hdiutil convert ./HS.cdr.dmg -format UDTO -o ./HS.iso

mv ./HS.iso.cdr ~/Desktop/HS.iso

rm ./HS.cdr.dmg