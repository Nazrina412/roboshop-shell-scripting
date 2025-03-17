source common.sh
component=mysl

PRINT MYSQL INSTALL
dnf install mysql-server -y
STAT $?

PRINT MYSQL ENABLE
systemctl enable mysqld
STAT $?

PRINT Start service
systemctl start mysqld
mysql_secure_installation --set-root-pass RoboShop@1
STAT $?