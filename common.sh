LOG_File=/tmp/roboshop.log
rm -f $LOG_File

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
          fi

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

  PRINT copy service file
  cp ${component}.service /etc/systemd/system/${component}.service &>>LOG_File
  STAT $?

  PRINT Copy mongodb repo file
  cp mongo.repo /etc/yum.repos.d/mongo.repo &>>LOG_File
  STAT $?



  PRINT add user
  useradd roboshop &>>LOG_File
  STAT $?

  PRINT cleaning old content
  rm -rf /app &>>LOG_File
  STAT $?

  PRINT create directory
  mkdir /app &>>LOG_File
  STAT $?

  PRINT download app file
  curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}-v3.zip &>>LOG_File
  STAT $?

  PRINT go to directory
  cd /app &>>LOG_File
  echo $?

  PRINT unzip file
  unzip /tmp/${component}.zip &>>LOG_File
  STAT $?

  cd /app &>>LOG_File

 PRINT install dependencies
 npm install &>>LOG_File
 STAT $?

 PRINT starting the service
 systemctl daemon-reload &>>LOG_File
 systemctl enable ${component} &>>LOG_File
 systemctl start ${component} &>>LOG_File
 STAT $?
}