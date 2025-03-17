source common.sh
component=frontend
app_path=/usr/share/nginx/html

PRINT Disable Nginx Default version
dnf module disable nginx -y &>>LOG_File
STAT $?

PRINT enable nginx
dnf module enable nginx:1.24 -y &>>LOG_File
STAT $?

PRINT install nginx
dnf install nginx -y &>>LOG_File
STAT $?

PRINT copy nginx config file
cp nginx.conf /etc/nginx/nginx.conf &>>LOG_File
STAT $?

APP_Prequisite

PRINT Start the service
systemctl enable nginx &>>LOG_File
systemctl restart nginx &>>LOG_File
STAT $?