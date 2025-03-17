LOG_File=/tmp/roboshop.log
rm -f $LOG_File
code_dir=$(pwd)

PRINT() {
 echo &>>LOG_File
 echo &>>LOG_File
 echo "############################# $* ###################################" &>>LOG_File
 echo $*
}

STAT() {
  if [ $1 -eq 0 ]; then
        echo -e "\e[32mSUCCESS\e[0m"
        else
          echo -e "\e[31mFAILURE\e[0m"
          echo "Refer the log file for more information"

          exit $1
           fi

}

APP_Prequisite() {
PRINT add user
  id roboshop &>>LOG_File
  if [ $? -ne 0 ]; then
     useradd roboshop &>>LOG_File

PRINT remove old content
rm -rf ${app_path} &>>LOG_File
STAT $?

PRINT Create directory
mkdir ${app_path} &>>LOG_File
STAT $?

PRINT download app
curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/{component}-v3.zip
STAT $?

PRINT extract content
cd ${app_path} &>>LOG_File
unzip /tmp/${component}.zip  &>>$LOG_File
STAT $?
}

System_setup() {
  PRINT copy service file
    cp ${code_dir}/${component}.service /etc/systemd/system/${component}.service &>>LOG_File
    STAT $?

  PRINT starting the service
   systemctl daemon-reload &>>LOG_File
   systemctl enable ${component} &>>LOG_File
   systemctl start ${component} &>>LOG_File
   STAT $?

}
Nodejs() {
  PRINT Disable Nodejs Default version
  dnf module disable nodejs -y &>>LOG_File
  STAT $?

  PRINT enable Nodejs  version 20 module
  dnf module enable nodejs:20 -y &>>LOG_File
  STAT $?

  PRINT install NodeJs
  dnf install nodejs -y
  STAT $?








  fi
  STAT $?

  APP_Prequisite



 PRINT install dependencies
 npm install &>>LOG_File
 STAT $?
 Schema
 System_setup


}

Java() {

  PRINT inatall maven
  dnf install maven -y


  PRINT dependencies Maven
  mvn clean package
  mv target/shipping-1.0.jar shipping.jar
  STAT $?

  APP_Prequisite





  mysql -h 172.31.94.140 -uroot -pRoboShop@1 < /app/db/schema.sql
  mysql -h 172.31.94.140 -uroot -pRoboShop@1 < /app/db/app-user.sql
  mysql -h 172.31.94.140 -uroot -pRoboShop@1 < /app/db/master-data.sql

}

Schema() {
  if ['schema' = 'mongo']; then
   PRINT Copy mongodb repo file
    cp mongo.repo /etc/yum.repos.d/mongo.repo &>>LOG_File
    STAT $?

  PRINT Install mongodb client
  dnf install mongodb-mongosh -y
  STAT $?

  PRINT Load Master data
  mongosh --host localhost </app/db/master-data.js
  STAT $?

  if ['schema' = 'mysql']; then
  PRINT Install mysql client &>>LOG_File
    dnf dnf install mysql -y &>>LOG_File
    STAT $?

  PRINT LOAD Schema
  mysql -h 172.31.94.140 -uroot -pRoboShop@1 < /app/db/schema.sql
  STAT $?

  PRINT LOAD mASTER DATA
  mysql -h 172.31.94.140 -uroot -pRoboShop@1 < /app/db/app-user.sql
   STAT $?

  PRINT Create App users
  mysql -h 172.31.94.140 -uroot -pRoboShop@1 < /app/db/master-data.sql
  STAT $?
  fi


