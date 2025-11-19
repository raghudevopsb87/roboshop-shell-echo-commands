
echo Disable NodeJS Default Version

echo
dnf module disable nodejs -y &>>/tmp/roboshop.log


echo Enable NodeJS 20 Version

echo
dnf module enable nodejs:20 -y &>>/tmp/roboshop.log


echo Install NodeJS

echo

dnf install nodejs -y &>>/tmp/roboshop.log


echo Add Application User

echo
useradd roboshop &>>/tmp/roboshop.log


echo Copy SystemD service file

echo
cp catalogue.service /etc/systemd/system/catalogue.service &>>/tmp/roboshop.log


echo Copy Mongo Repo file for mongo client


cp mongo.repo /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log


echo Create Application Directory

echo
mkdir /app &>>/tmp/roboshop.log


echo Download application content

echo
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip &>>/tmp/roboshop.log
cd /app


echo Unzip applicaiton content

echo
unzip /tmp/catalogue.zip &>>/tmp/roboshop.log

cd /app


echo Downlaod NodeJS Dependencies

echo
npm install &>>/tmp/roboshop.log


echo Install Mongo Client

echo
dnf install mongodb-mongosh -y &>>/tmp/roboshop.log


echo Load Schema
\
echo
mongosh --host mongodb-dev.rdevopsb87.online </app/db/master-data.js &>>/tmp/roboshop.log


echo Restart catalogue service

echo
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable catalogue &>>/tmp/roboshop.log
systemctl restart catalogue &>>/tmp/roboshop.log

