source common.sh
component=mongo

PRINT Copy repo file
cp mongo.repo /etc/yum.repos.d/mongo.repo
STAT $?

PRINT Install mongodb
dnf install mongodb-org -y
STAT $?

PRINT update config file
sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
STAT $?

PRINT Start mongodb service
systemctl enable mongod
systemctl restart mongod
STAT $?