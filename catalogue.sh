echo Disable NodeJS Default Version
dnf module disable nodejs -y

echo Enable NodeJS 20 Version
dnf module enable nodejs:20 -y

echo Install NodeJS
dnf install nodejs -y

echo Add Application User
useradd roboshop

echo Copy SystemD service file
cp catalogue.service /etc/systemd/system/catalogue.service

echo Copy Mongo Repo file for mongo client
cp mongo.repo /etc/yum.repos.d/mongo.repo

echo Create Application Directory
mkdir /app

echo Download application content
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip
cd /app

echo Unzip applicaiton content
unzip /tmp/catalogue.zip

cd /app

echo Downlaod NodeJS Dependencies
npm install

echo Install Mongo Client
dnf install mongodb-mongosh -y

echo Load Schema
mongosh --host mongodb-dev.rdevopsb87.online </app/db/master-data.js

echo Restart catalogue service
systemctl daemon-reload
systemctl enable catalogue
systemctl restart catalogue

