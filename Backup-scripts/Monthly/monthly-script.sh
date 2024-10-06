#!/bin/ash
# Define directories
target_dir="/nginx"
weekly_dir="/Backup/Weekly/nginx"
monthly_dir="/Backup/Monthly/nginx"

# Ensure the Daily directory exists and navigate to it
if ! cd "$monthly_dir"; then
  mkdir -p "$monthly_dir" && cd "$monthly_dir" || { echo "Failed to create and access $monthly_dir"; exit 1; }
fi

# Archive last month's weekly backups
archive_file="$monthly_dir/$(date -d "-30 days" +%Y-%m-%d)-to-$(date +%Y-%m-%d).tar.gz"
find "$weekly_dir" -type f | tar -czf "$archive_file" -T - || { echo "Failed to archive weekly backups"; exit 1; }

find "$monthly_dir" -type f -mtime +365 -delete || { echo "Failed to delete old files"; exit 1; }