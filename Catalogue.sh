source common.sh
component=catalogue
Nodejs
dnf install mongodb-mongosh -y
mongosh --host localhost </app/db/master-data.js
