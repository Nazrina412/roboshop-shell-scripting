source common.sh
component=redis

PRINT Disable redis default
dnf module disable redis -y &>>LOG_File
STAT $?

PRINT Enable redis
dnf module enable redis:7 -y &>>LOG_File
STAT $?

PRINT Install Redis
dnf install redis -y &>>LOG_File
STAT $?

PRINT Update redis Config
sed -i '/^bind/ s/127.0.0.1/0.0.0.0/' /etc/redis/redis.conf &>>LOG_File
sed -i '/protected-mode/ c protected-mode no' /etc/redis/redis.conf &>>LOG_File
STAT $?

PRINT Start Redis service
systemctl enable redis &>>LOG_File
systemctl restart redis &>>LOG_File
STAT $?