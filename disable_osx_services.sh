#!/bin/bash

# original idea and content from
# https://gist.github.com/pansen/db14d1e0a4257b55a4e6d84600d617ee

# @pansen reduced that to some obvious unwanted services, rather than performing a big-hammer action

# Agents to disable
TODISABLE=( \
	'com.apple.photoanalysisd' \
	'com.apple.telephonyutilities.callservicesd' \
	'com.apple.familycircled' \
	'com.apple.familycontrols.useragent' \
	'com.apple.familynotificationd' \
	'com.apple.gamed' \
	'com.apple.icloud.findmydeviced.findmydevice-user-agent' \
	'com.apple.cloudfamilyrestrictionsd-mac' \
	'com.apple.cloudphotosd' \
	'com.apple.cloudpaird' \
	'com.apple.assistant_service' \
	'com.apple.CallHistorySyncHelper' \
	'com.apple.CallHistoryPluginHelper' \
	'com.apple.AOSPushRelay' \
	'com.apple.geodMachServiceBridge' \
	'com.apple.syncdefaultsd' \
	'com.apple.security.cloudkeychainproxy3' \
	'com.apple.security.idskeychainsyncingproxy' \
	'com.apple.security.keychain-circle-notification' \
	'com.apple.cloudd' \
	'com.apple.assistantd' \
	'com.apple.parentalcontrols.check' \
	'com.apple.parsecd' \
	'com.apple.sharingd' \
	'com.apple.CommCenter-osx' \
	'com.apple.identityservicesd' \
	)


for agent in "${TODISABLE[@]}"
do
    sudo launchctl unload -w /System/Library/LaunchAgents/${agent}.plist
    launchctl unload -w /System/Library/LaunchAgents/${agent}.plist
    echo "[OK] Agent ${agent} Disabled"
done


# Daemons to disable
TODISABLE=( \
	'com.apple.preferences.timezone.admintool' \
	'com.apple.remotepairtool' \
	'com.apple.rpmuxd' \
	'com.apple.security.FDERecoveryAgent' \
	'com.apple.icloud.findmydeviced' \
	'com.apple.findmymacmessenger' \
	'com.apple.familycontrols' \
	'com.apple.findmymac' \
	'com.apple.screensharing' \
	'com.apple.apsd' \
	'com.apple.AOSNotificationOSX' \
	'com.apple.FileSyncAgent.sshd' \
	'com.apple.ManagedClient.cloudconfigurationd' \
	'com.apple.ManagedClient.enroll' \
	'com.apple.ManagedClient' \
	'com.apple.ManagedClient.startup' \
	'com.apple.iCloudStats' \
	'com.apple.locationd' \
	'com.apple.mbicloudsetupd' \
	'com.apple.awacsd' \
	'com.apple.familycontrols' \
	)


for daemon in "${TODISABLE[@]}"
do
    sudo launchctl unload -w /System/Library/LaunchDaemons/${daemon}.plist
    launchctl unload -w /System/Library/LaunchDaemons/${daemon}.plist
    echo "[OK] Daemon ${daemon} Disabled"
done


# /System/Library/LaunchAgents/com.apple.geodMachServiceBridge.plist: Operation not permitted while System Integrity Protection is engaged
# /System/Library/LaunchAgents/com.apple.security.idskeychainsyncingproxy.plist: Operation not permitted while System Integrity Protection is engaged
# /System/Library/LaunchAgents/com.apple.security.keychain-circle-notification.plist: Operation not permitted while System Integrity Protection is engaged
