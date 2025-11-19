echo -e \\e[35m===================================================\\e[0m
echo Disable NodeJS Default Version
echo -e \\e[35m===================================================\\e[0m
echo
dnf module disable nodejs -y

echo -e \\e[35m===================================================\\e[0m
echo Enable NodeJS 20 Version
echo -e \\e[35m===================================================\\e[0m
echo
dnf module enable nodejs:20 -y

echo -e \\e[35m===================================================\\e[0m
echo Install NodeJS
echo -e \\e[35m===================================================\\e[0m
echo

dnf install nodejs -y

echo -e \\e[35m===================================================\\e[0m
echo Add Application User
echo -e \\e[35m===================================================\\e[0m
echo
useradd roboshop

echo -e \\e[35m===================================================\\e[0m
echo Copy SystemD service file
echo -e \\e[35m===================================================\\e[0m
echo
cp catalogue.service /etc/systemd/system/catalogue.service

echo -e \\e[35m===================================================\\e[0m
echo Copy Mongo Repo file for mongo client
echo -e \\e[35m===================================================\\e[0m

cp mongo.repo /etc/yum.repos.d/mongo.repo

echo -e \\e[35m===================================================\\e[0m
echo Create Application Directory
echo -e \\e[35m===================================================\\e[0m
echo
mkdir /app

echo -e \\e[35m===================================================\\e[0m
echo Download application content
echo -e \\e[35m===================================================\\e[0m
echo
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip
cd /app

echo -e \\e[35m===================================================\\e[0m
echo Unzip applicaiton content
echo -e \\e[35m===================================================\\e[0m
echo
unzip /tmp/catalogue.zip

cd /app

echo -e \\e[35m===================================================\\e[0m
echo Downlaod NodeJS Dependencies
echo -e \\e[35m===================================================\\e[0m
echo
npm install

echo -e \\e[35m===================================================\\e[0m
echo Install Mongo Client
echo -e \\e[35m===================================================\\e[0m
echo
dnf install mongodb-mongosh -y

echo -e \\e[35m===================================================\\e[0m
echo Load Schema
echo -e \\e[35m===================================================\\e[0m\
echo
mongosh --host mongodb-dev.rdevopsb87.online </app/db/master-data.js

echo -e \\e[35m===================================================\\e[0m
echo Restart catalogue service
echo -e \\e[35m===================================================\\e[0m
echo
systemctl daemon-reload
systemctl enable catalogue
systemctl restart catalogue

