#!/bin/bash

SERVICE_NAME="nginx"
EMAIL="admin@example.com"
LOG_FILE="/var/log/service_monitor.log"

# Check if the service is running
if ! systemctl is-active --quiet $SERVICE_NAME; then
    echo "$(date): $SERVICE_NAME is down. Restarting..." >> $LOG_FILE
    systemctl restart $SERVICE_NAME
    
    # Check if the service restarted successfully
    if systemctl is-active --quiet $SERVICE_NAME; then
        echo "$(date): $SERVICE_NAME restarted successfully." >> $LOG_FILE
    else
        echo "$(date): Failed to restart $SERVICE_NAME. Sending alert email." >> $LOG_FILE
        echo "$SERVICE_NAME is down and failed to restart" | mail -s "$SERVICE_NAME Service Down" $EMAIL
    fi
fi


#Explanation:

#Purpose: Monitors a critical service (e.g., Nginx) and attempts to restart it if it's not running. If the restart fails, it sends an alert email.
#Key Steps:
#Check Service Status: Uses systemctl to check if the service is running.
#Restart Service: If the service is down, the script attempts to restart it.
#Alerting: If the restart fails, an alert email is sent to notify the administrator.