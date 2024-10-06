#!/bin/ash
# Define directories
target_dir="/nginx/"
weekly_dir="/Backup/Weekly/nginx"
daily_dir="/Backup/Daily/nginx"

# Ensure the Daily directory exists and navigate to it
if ! cd "$weekly_dir"; then
  mkdir -p "$weekly_dir" && cd "$weekly_dir" || { echo "Failed to create and access $weekly_dir"; exit 1; }
fi

# Perform a full incremental backup
weekly_snapshot="full-$(date +%Y-%m-%d).ss"
weekly_backup="full-$(date +%Y-%m-%d).tar"
tar -cf "$weekly_backup" -g "$weekly_snapshot" "$target_dir" || { echo "Failed to create full backup archive $weekly_backup"; exit 1; }

# Archive last week's daily backups
archive_file="$weekly_dir/$(date -d "-7 days" +%Y-%m-%d)-to-$(date +%Y-%m-%d).tar.gz"
find "$daily_dir" -type f | tar -czf "$archive_file" -T - || { echo "Failed to archive daily backups"; exit 1; }

# Delete files older than 30 days
find "$weekly_dir" -type f -mtime +30 -delete || { echo "Failed to delete old files"; exit 1; }