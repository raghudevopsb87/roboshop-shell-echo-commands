echo ===================================================
echo Disable NodeJS Default Version
echo ===================================================
echo
dnf module disable nodejs -y

echo ===================================================
echo Enable NodeJS 20 Version
echo ===================================================
echo
dnf module enable nodejs:20 -y

echo ===================================================
echo Install NodeJS
echo ===================================================
echo

dnf install nodejs -y

echo ===================================================
echo Add Application User
echo ===================================================
echo
useradd roboshop

echo ===================================================
echo Copy SystemD service file
echo ===================================================
echo
cp catalogue.service /etc/systemd/system/catalogue.service

echo ===================================================
echo Copy Mongo Repo file for mongo client
echo ===================================================

cp mongo.repo /etc/yum.repos.d/mongo.repo

echo ===================================================
echo Create Application Directory
echo ===================================================
echo
mkdir /app

echo ===================================================
echo Download application content
echo ===================================================
echo
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip
cd /app

echo ===================================================
echo Unzip applicaiton content
echo ===================================================
echo
unzip /tmp/catalogue.zip

cd /app

echo ===================================================
echo Downlaod NodeJS Dependencies
echo ===================================================
echo
npm install

echo ===================================================
echo Install Mongo Client
echo ===================================================
echo
dnf install mongodb-mongosh -y

echo ===================================================
echo Load Schema
echo ===================================================\
echo
mongosh --host mongodb-dev.rdevopsb87.online </app/db/master-data.js

echo ===================================================
echo Restart catalogue service
echo ===================================================
echo
systemctl daemon-reload
systemctl enable catalogue
systemctl restart catalogue

