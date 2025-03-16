LOG_File=/tmp/roboshop.log
rm -f $LOG_File

Nodejs() {
  echo Disable Nodejs Default version
  dnf module disable nodejs -y $>>LOG_File

  echo enable Nodejs  version 20 module
  dnf module enable nodejs:20 -y $>>LOG_File

  echo install NodeJs
  dnf install nodejs -y

  echo copy service file
  cp ${component}.service /etc/systemd/system/${component}.service $>>LOG_File

 echo Copy mongodb repo file
 cp mongo.repo /etc/yum.repos.d/mongo.repo $>>LOG_File

 echo install Nodejs $>>LOG_File


 echo add user
 useradd roboshop $>>LOG_File

 echo cleaning old content
 rm -rf /app $>>LOG_File


 echo create directory
 mkdir /app $>>LOG_File

 echo download app file
 curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}-v3.zip $>>LOG_File

 echo go to directory
 cd /app $>>LOG_File


 echo unzip file
 unzip /tmp/${component}.zip $>>LOG_File

cd /app $>>LOG_File

 echo starting the service
 npm install $>>LOG_File
 systemctl daemon-reload $>>LOG_File
 systemctl enable ${component} $>>LOG_File
 systemctl start ${component} $>>LOG_File
}