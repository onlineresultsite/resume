#!/bin/bash

# Define variables for the project directory and settings file
PROJECT_DIR="/home/ubuntu/Resume"
SETTINGS_FILE="$PROJECT_DIR/resume/settings.py"
VENV_DIR="/home/ubuntu/env"
IP_ADDRESS="13.51.109.155"

# Print the current directory
echo "Current directory: $(pwd)"

# Navigate to the project directory
cd $PROJECT_DIR || { echo "Failed to navigate to project directory"; exit 1; }

# Print the current directory after navigation
echo "After cd, directory: $(pwd)"

# List files in the current directory to check for manage.py
echo "Listing files in the project directory:"
ls -la

# Ensure the settings file exists
if [ ! -f $SETTINGS_FILE ]; then
    echo "Settings file not found: $SETTINGS_FILE"
    exit 1
fi

# Update the settings file with the allowed host IP address
sed -i "s/\[\]/\[\"$IP_ADDRESS\"\]/" $SETTINGS_FILE

# Activate the virtual environment
source $VENV_DIR/bin/activate || { echo "Failed to activate virtual environment"; exit 1; }

# Ensure the script is in the project directory each time it runs a Django command
cd $PROJECT_DIR || { echo "Failed to navigate to project directory"; exit 1; }
# Check if manage.py exists in the current directory
if [ ! -f manage.py ]; then
    echo "manage.py not found in the current directory: $(pwd)"
    exit 1
fi
python3 manage.py makemigrations || { echo "Failed to run makemigrations"; exit 1; }

cd $PROJECT_DIR || { echo "Failed to navigate to project directory"; exit 1; }
python3 manage.py migrate || { echo "Failed to run migrate"; exit 1; }

cd $PROJECT_DIR || { echo "Failed to navigate to project directory"; exit 1; }
python3 manage.py collectstatic --noinput || { echo "Failed to run collectstatic"; exit 1; }

# Restart Gunicorn and Nginx services
sudo service gunicorn restart || { echo "Failed to restart Gunicorn"; exit 1; }
sudo service nginx restart || { echo "Failed to restart Nginx"; exit 1; }

echo "Deployment script completed successfully."
