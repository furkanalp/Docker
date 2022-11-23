wget --content-disposition https://github.com/linuxacademy/content-Introduction-to-Containers-and-Docker/raw/master/lessonfiles/demo-app.tar
ls
tar -xf demo-app.tar 
ls
cd app/
ls
#after creating Dockerfile
docker build . -t appimage
docker run -dt --name app01 appimage
docker inspect app01 | grep IPAddress
curl 172.17.0.2:8080