from airflow import DAG
from airflow.operators.email_operator import EmailOperator
from datetime import datetime, timedelta

# Define the default arguments for the DAG
default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'email_on_failure': True,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

# Define the DAG object
with DAG('send_email_dag',
         default_args=default_args,
         schedule_interval='0 17 * * *',  # Schedule to run daily at 5 PM UTC
         start_date=datetime(2024, 6, 16, 17, 0, 0),  # Start date and time (today at 5 PM UTC)
         catchup=False) as dag:

    # Define the task to send the email
    send_email = EmailOperator(
        task_id='send_email_task',
        to='samichi.rungta@gmail.com',  # Replace with recipient's email address
        subject='Airflow Email Test',
        html_content='<h3>Email sent from Airflow!</h3>'
    )

# Define the task dependencies (if any)
send_email  # Define the task dependency graph

