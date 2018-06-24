#!/system/bin/sh
# Please don't hardcode /magisk/modname/... ; instead, please use $MODDIR/...
# This will make your scripts compatible even if Magisk change its mount point in the future
MODDIR=${0%/*}

# This script will be executed in late_start service mode
# More info in the main Magisk thread
su -c 'chmod 777 /system/bin/sqlite3'
# restoring database
echo "Enabling Android Messages for Web (Hopefully)"
cmd="\"UPDATE Flags SET boolVal=1 WHERE packageName LIKE '%messaging%' AND name LIKE '%PhenotypeOverrideRollout%'\""
echo "Executing command '${cmd}'"
su -c "sqlite3 /data/data/com.google.android.gms/databases/phenotype.db  \"UPDATE Flags SET boolVal=1 WHERE packageName LIKE '%messaging%' AND name LIKE '%PhenotypeOverrideRollout%'\";"
echo "Command status is $?"
cmd="UPDATE Flags SET boolVal=1 WHERE packageName LIKE '%messaging%' AND name LIKE '%bugle_phenotype__enable_multi_device%';"
echo "Executing command '${cmd}'"
su -c "sqlite3 /data/data/com.google.android.gms/databases/phenotype.db  \"UPDATE Flags SET boolVal=1 WHERE packageName LIKE '%messaging%' AND name LIKE '%bugle_phenotype__enable_multi_device%';\";"
echo "Command status is $?"
cmd="UPDATE Flags SET boolVal=1 WHERE packageName LIKE '%com.google.android.apps.messaging%' AND name LIKE '%MultiQueueRollout__launched__%';"
echo "Executing command '${cmd}'"
su -c "sqlite3 /data/data/com.google.android.gms/databases/phenotype.db  \"UPDATE Flags SET boolVal=1 WHERE packageName LIKE '%com.google.android.apps.messaging%' AND name LIKE '%MultiQueueRollout__launched__%'\";"
echo "Command status is $?"
cmd="UPDATE Flags SET boolVal=1 WHERE packageName LIKE '%com.google.android.apps.messaging%' AND name LIKE '%MultiDeviceRollout__launched__%';"
echo "Executing command '${cmd}'"
su -c "sqlite3 /data/data/com.google.android.gms/databases/phenotype.db  \"UPDATE Flags SET boolVal=1 WHERE packageName LIKE '%com.google.android.apps.messaging%' AND name LIKE '%MultiDeviceRollout__launched__%'\";"
echo "Command status is $?"
echo "Records updated successfully!"
echo "Restarting messaging app"
am force-stop com.google.android.apps.messaging