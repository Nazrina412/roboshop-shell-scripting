

PRINT Disable redis default
dnf module disable redis -y
STAT $?

PRINT Enable redis
dnf module enable redis:7 -y
STAT $?

PRINT Install Redis
dnf install redis -y
STAT $?

PRINT Update redis Config
sed -i '/^bind/ s/127.0.0.1/0.0.0.0/' /etc/redis/redis.conf
sed -i '/protected-mode/ c protected-mode no' /etc/redis/redis.conf
STAT $?

PRINT Start Redis service
systemctl enable redis
systemctl restart redis
STAT $?