#!/bin/sh

# Configure upper case strings before use!

owncloudcmd -u USER -p 'PASSWORD' BACKUP_FOLDER https://HOST/remote.php/webdav/FOLDER_TO_SYNC_TO
