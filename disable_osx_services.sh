#!/bin/bash

# original idea and content from
# https://gist.github.com/pansen/db14d1e0a4257b55a4e6d84600d617ee

# @pansen reduced that to some obvious unwanted services, rather than performing a big-hammer action

# Agents to disable
TODISABLE=( \
	'com.apple.familycircled' \
	'com.apple.familycontrols.useragent' \
	'com.apple.familynotificationd' \
	'com.apple.gamed' \
	'com.apple.icloud.findmydeviced.findmydevice-user-agent' \
	'com.apple.cloudfamilyrestrictionsd-mac' \
	'com.apple.geodMachServiceBridge' \
	'com.apple.parentalcontrols.check' \
	'com.apple.parsecd' \
	)


for agent in "${TODISABLE[@]}"
do
	if [ -f /System/Library/LaunchAgents/${agent}.plist ]; then
	    sudo launchctl unload -w /System/Library/LaunchAgents/${agent}.plist
	    launchctl unload -w /System/Library/LaunchAgents/${agent}.plist
	    echo "[OK] Agent ${agent} Disabled"
	fi
done


# Daemons to disable
TODISABLE=( \
	'com.apple.remotepairtool' \
	'com.apple.rpmuxd' \
	'com.apple.icloud.findmydeviced' \
	'com.apple.findmymacmessenger' \
	'com.apple.familycontrols' \
	'com.apple.findmymac' \
	'com.apple.screensharing' \
	'com.apple.ManagedClient.cloudconfigurationd' \
	'com.apple.ManagedClient.enroll' \
	'com.apple.ManagedClient' \
	'com.apple.ManagedClient.startup' \
	'com.apple.locationd' \
	'com.apple.familycontrols' \
	)


for daemon in "${TODISABLE[@]}"
do
	if [ -f /System/Library/LaunchDaemons/${agent}.plist ]; then
	    sudo launchctl unload -w /System/Library/LaunchDaemons/${daemon}.plist
	    launchctl unload -w /System/Library/LaunchDaemons/${daemon}.plist
	    echo "[OK] Daemon ${daemon} Disabled"
	fi
done


# /System/Library/LaunchAgents/com.apple.geodMachServiceBridge.plist: Operation not permitted while System Integrity Protection is engaged
# /System/Library/LaunchAgents/com.apple.security.idskeychainsyncingproxy.plist: Operation not permitted while System Integrity Protection is engaged
# /System/Library/LaunchAgents/com.apple.security.keychain-circle-notification.plist: Operation not permitted while System Integrity Protection is engaged
