echo Log file output is being written to - /tmp/roboshop.log

echo Disable NodeJS Default Version
dnf module disable nodejs -y &>>/tmp/roboshop.log
echo $?


echo Enable NodeJS 20 Version
dnf module enable nodejs:20 -y &>>/tmp/roboshop.log
echo $?


echo Install NodeJS
dnf install nodejs -y &>>/tmp/roboshop.log
echo $?


echo Add Application User
useradd roboshop &>>/tmp/roboshop.log
echo $?

echo Copy SystemD service file
cp catalogue.service /etc/systemd/system/catalogue.service &>>/tmp/roboshop.log


echo Copy Mongo Repo file for mongo client
cp mongo.repo /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log
echo $?

echo Create Application Directory
mkdir /app &>>/tmp/roboshop.log
echo $?

echo Download application content
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip &>>/tmp/roboshop.log
echo $?
cd /app


echo Unzip applicaiton content
unzip /tmp/catalogue.zip &>>/tmp/roboshop.log
echo $?
cd /app


echo Downlaod NodeJS Dependencies
npm install &>>/tmp/roboshop.log
echo $?

echo Install Mongo Client
dnf install mongodb-mongosh -y &>>/tmp/roboshop.log
echo $?

echo Load Schema
mongosh --host mongodb-dev.rdevopsb87.online </app/db/master-data.js &>>/tmp/roboshop.log
echo $?

echo Restart catalogue service
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable catalogue &>>/tmp/roboshop.log
systemctl restart catalogue &>>/tmp/roboshop.log
echo $?

