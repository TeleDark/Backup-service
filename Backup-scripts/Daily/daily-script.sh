#!/bin/ash
# Define directories
target_dir="/nginx/"
daily_dir="/Backup/Daily/nginx"

# Ensure the Daily directory exists and navigate to it
if ! cd "$daily_dir"; then
  mkdir -p "$daily_dir" && cd "$daily_dir" || { echo "Failed to create and access $daily_dir"; exit 1; }
fi

# Define snapshot files
yesterday_snapshot=$(date -d "-1 days" +%Y-%m-%d).ss
today_snapshot=$(date +%Y-%m-%d).ss
backup_file=$(date +%Y-%m-%d).tar

if [ -f "$yesterday_snapshot" ]; then
    cp "$yesterday_snapshot" "$today_snapshot"
else 
    touch "$today_snapshot"
fi

# Perform an incremental backup of the target directory
tar -cf "$backup_file" -g "$today_snapshot" "$target_dir" || { echo "Failed to create backup archive"; exit 1; }

# Delete files older than 7 days
find $daily_dir/* -mtime +7 -delete