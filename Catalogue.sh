source common.sh
component=catalogue
echo $?

Nodejs
echo $?

dnf install mongodb-mongosh -y
mongosh --host localhost </app/db/master-data.js
echo $?
