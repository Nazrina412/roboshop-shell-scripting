LOG_File=/tmp/roboshop.log
rm -f $LOG_File

PRINT() {
 echo &>>LOG_File
 echo &>>LOG_File
 echo "############################# $* ###################################" &>>LOG_File
 echo $*
}

Nodejs() {
  PRINT Disable Nodejs Default version
  dnf module disable nodejs -y &>>LOG_File
  if [ $? -eq 0 ]; then
    echo Success
    else
      echo failure
      fi

  PRINT enable Nodejs  version 20 module
  dnf module enable nodejs:20 -y &>>LOG_File
  if [ $? -eq 0 ]; then
      echo Success
      else
        echo failure
        fi

  PRINT install NodeJs
  dnf install nodejs -y
  if [ $? -eq 0 ]; then
      echo Success
      else
        echo failure
        fi

  PRINT copy service file
  cp ${component}.service /etc/systemd/system/${component}.service &>>LOG_File
  if [ $? -eq 0 ]; then
      echo Success
      else
        echo failure
        fi

  PRINT Copy mongodb repo file
  cp mongo.repo /etc/yum.repos.d/mongo.repo &>>LOG_File
  if [ $? -eq 0 ]; then
      echo Success
      else
        echo failure
        fi



  PRINT add user
  useradd roboshop &>>LOG_File
  if [ $? -eq 0 ]; then
      echo Success
      else
        echo failure
        fi

  PRINT cleaning old content
  rm -rf /app &>>LOG_File
  if [ $? -eq 0 ]; then
      echo Success
      else
        echo failure
        fi

  PRINT create directory
  mkdir /app &>>LOG_File
  if [ $? -eq 0 ]; then
      echo Success
      else
        echo failure
        fi

  PRINT download app file
  curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}-v3.zip &>>LOG_File
  if [ $? -eq 0 ]; then
      echo Success
      else
        echo failure
        fi

  PRINT go to directory
  cd /app &>>LOG_File
  echo $?

  PRINT unzip file
  unzip /tmp/${component}.zip &>>LOG_File
  if [ $? -eq 0 ]; then
      echo Success
      else
        echo failure
        fi

  cd /app &>>LOG_File

 PRINT install dependencies
 npm install &>>LOG_File
 if [ $? -eq 0 ]; then
     echo Success
     else
       echo failure
       fi

 PRINT starting the service
 systemctl daemon-reload &>>LOG_File
 systemctl enable ${component} &>>LOG_File
 systemctl start ${component} &>>LOG_File
 if [ $? -eq 0 ]; then
     echo Success
     else
       echo failure
       fi
}