### Backup Service

The repository includes a folder named `Backup-scripts/`, which contains three subdirectories: `Daily`, `Weekly`, and `Monthly`. Each of these directories holds scripts for creating daily, weekly, and monthly backups.

To set up backups for a specific directory, follow these steps:

1. **Copy the Scripts**: 
   - Navigate to the `Daily`, `Weekly`, and `Monthly` directories.
   - For each directory (Daily, Weekly, and Monthly), copy the respective script.
   
2. **Rename the Scripts**: 
   - Rename each script to match the name of the directory you want to back up. For example, if you want to back up a folder named `logs`, you would rename the scripts to something like `daily-logs.sh`, `weekly-logs.sh`, and `monthly-logs.sh`.

3. **Modify the Target Directory**:
   - Open each copied script and modify the `target_dir` variable to the full path of the directory you want to back up. For example, if the folder you want to back up is located at `/var/logs`, change the `target_dir` value to `/var/logs`.

4. **Backup Automation**:
   - The backup scripts are executed automatically using the `crond` service in the `backup` container, as defined in the `docker-compose.yaml` file.
   - The scripts are designed to handle incremental backups for daily operations, compress weekly backups, and archive them for long-term monthly storage.

Make sure the directories you want to back up are properly mounted in the `backup` service within the `docker-compose.yaml` file. This allows the scripts to access and back up the specified directories.

For more details, refer to the actual scripts located in the `Backup-scripts` directory of the project.