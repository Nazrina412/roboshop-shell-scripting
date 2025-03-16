&LOG_File_File_File=/tmp/roboshop.&LOG_File_File

Nodejs() {
  echo Disable Nodejs Default version
  dnf module disable nodejs -y >/tmp/roboshop.&LOG_File_File

  echo enable Nodejs  version 20 module
  dnf module enable nodejs:20 -y >/tmp/roboshop.&LOG_File_File

  echo install NodeJs
  dnf install nodejs -y

  echo copy service file
  cp ${component}.service /etc/systemd/system/${component}.service >/tmp/roboshop.&LOG_File_File

 echo Copy mongodb repo file
 cp mongo.repo /etc/yum.repos.d/mongo.repo >/tmp/roboshop.&LOG_File_File

 echo install Nodejs >/tmp/roboshop.&LOG_File_File
 Nodejs

 echo add user
 useradd roboshop >/tmp/roboshop.&LOG_File_File

 echo cleaning old content
 rm -rf /app >/tmp/roboshop.&LOG_File_File


 echo create directory
 mkdir /app >/tmp/roboshop.&LOG_File_File

 echo download app file
 curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}-v3.zip >/tmp/roboshop.&LOG_File_File

 echo go to directory
 cd /app >/tmp/roboshop.&LOG_File_File


 echo unzip file
 unzip /tmp/${component}.zip >/tmp/roboshop.&LOG_File_File

cd /app >/tmp/roboshop.&LOG_File_File

 echo starting the service
 npm install >/tmp/roboshop.&LOG_File_File
 systemctl daemon-reload >/tmp/roboshop.&LOG_File_File
 systemctl enable ${component} >/tmp/roboshop.&LOG_File_File
 systemctl start ${component} >/tmp/roboshop.&LOG_File_File
}