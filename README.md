# Database Backup with Airflow

This project uses Apache Airflow to automate the backup of a MySQL database and send email notifications based on the backup status. It includes tasks for checking disk space, dumping the database, deleting old backups, and sending email notifications.

## Project Structure

```
|-- dags/
|   |-- backup_mysql.py         # Airflow DAG definition file
|-- scripts/
|   |-- check_disk_size.sh      # Bash script to check disk space
|   |-- db_dump.sh              # Bash script to dump MySQL database
|   |-- delete_old_backups.sh   # Bash script to delete old backups
|   |-- credentials.sh          # Script to define database credentials (not included)
|-- README.md                   # This README file
```

## Prerequisites

- Python 3.x
- Apache Airflow
- MySQL database server
- Access to a mail server for sending email notifications

## Installation and Setup

1. **Clone the Repository:**
   ```bash
   git clone <repository_url>
   cd <repository_name>
   ```

2. **Install Required Packages:**
   ```bash
   pip install apache-airflow
   ```

3. **Initialize Airflow Database:**
   ```bash
   airflow db init
   ```

4. **Start the Airflow Scheduler and Webserver:**
   ```bash
   airflow scheduler &
   airflow webserver &
   ```

5. **Copy Scripts and DAG file:**
   - Place the scripts (`check_disk_size.sh`, `db_dump.sh`, `delete_old_backups.sh`) inside the `scripts` directory.
   - Copy the `backup_mysql.py` DAG definition file to the `dags` directory in your Airflow installation.

6. **Configure Database Credentials:**
   - Create a `credentials.sh` script in the `scripts` directory to define your MySQL database credentials:
     ```bash
     export DB_USER="your_db_user"
     export DB_PASS="your_db_password"
     export DB_NAME="your_db_name"
     ```

7. **Update Airflow Configuration:**
   - Adjust Airflow's configuration (`airflow.cfg`) as necessary for your environment, including SMTP settings for email notifications.

## Usage

1. **Access Airflow UI:**
   - Open a web browser and go to `http://localhost:8080` (or the appropriate URL) to access the Airflow UI.

2. **Enable the `backup_mysql` DAG:**
   - Navigate to the Airflow UI.
   - Locate the `backup_mysql` DAG in the list of DAGs and enable it.

3. **Monitor DAG Execution:**
   - View DAG runs, task statuses, and logs in the Airflow UI.
   - Check email notifications for backup status and disk space alerts.

## Troubleshooting

- **Task Failures:**
  - If tasks fail, check Airflow logs (`$AIRFLOW_HOME/logs`) for detailed error messages.
  - Ensure script paths (`bash_command` in operators) and permissions are correctly set.
  
- **Email Notifications:**
  - Verify SMTP server settings in Airflow configuration (`airflow.cfg`).
  - Check spam/junk folders for email notifications.
