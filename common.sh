LOG_File=/tmp/roboshop.log
rm -f &LOG_File

PRINT() {
 echo &>>LOG_File
 echo &>>LOG_File
 echo "############################# $* ###################################" &>>LOG_File

}

Nodejs() {
  PRINT Disable Nodejs Default version
  dnf module disable nodejs -y &>>LOG_File

  PRINT enable Nodejs  version 20 module
  dnf module enable nodejs:20 -y &>>LOG_File

  PRINT install NodeJs
  dnf install nodejs -y

  PRINT copy service file
  cp ${component}.service /etc/systemd/system/${component}.service &>>LOG_File

 PRINT Copy mongodb repo file
 cp mongo.repo /etc/yum.repos.d/mongo.repo &>>LOG_File

 PRINT install Nodejs &>>LOG_File


 PRINT add user
 useradd roboshop &>>LOG_File

 PRINT cleaning old content
 rm -rf /app &>>LOG_File


 PRINT create directory
 mkdir /app &>>LOG_File

 PRINT download app file
 curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}-v3.zip &>>LOG_File

 PRINT go to directory
 cd /app &>>LOG_File


 PRINT unzip file
 unzip /tmp/${component}.zip &>>LOG_File

  cd /app &>>LOG_File

 PRINT starting the service
 npm install &>>LOG_File
 systemctl daemon-reload &>>LOG_File
 systemctl enable ${component} &>>LOG_File
 systemctl start ${component} &>>LOG_File
}