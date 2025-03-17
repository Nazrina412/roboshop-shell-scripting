source common.sh
component=mongo

PRINT Copy repo file &>>LOG_File
cp mongo.repo /etc/yum.repos.d/mongo.repo &>>LOG_File
STAT $?

PRINT Install mongodb
dnf install mongodb-org -y &>>LOG_File
STAT $?

PRINT update config file
sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf &>>LOG_File
STAT $?

PRINT Start mongodb service
systemctl enable mongod &>>LOG_File
systemctl restart mongod &>>LOG_File
STAT $?