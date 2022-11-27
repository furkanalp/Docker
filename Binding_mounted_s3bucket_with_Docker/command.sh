sudo apt-get update -y
sudo apt-get install awscli
sudo apt-get install s3fs
aws configure
pwd
mkdir bucket && cd bucket && touch test1.txt test2.txt
aws s3 sync /home/ubuntu/bucket s3://writeyourbucketname
touch test3.txt #--> see, it works seamlessly


echo Youraccesskey:yoursecretaccesskey > $HOME/.password_s3fs
chmod 600 .password_s3fs #--> give read,write permission for this file
sudo s3fs yourbucketname bucket -o passwd_file=${HOME}/.password_s3fs,nonempty,rw,allow_other,mp_umask=002,uid=1000,gid=1000 -o url=http://s3.us-east-1.amazonaws.com,endpoint=us-east-1,use_path_request_style
mount | grep bucket #--> see, it is mounted successfully
cd bucket && touch test4.txt #--> check your bucket on AWS and see test4.txt is successfully uploaded
cd /etc
sudo cp fstab ftsab_bkp  #--> backup your fstab file
sudo vi fstab #--> and then add the line below
yourbucketname /home/ubuntu/bucket fuse.s3fs _netdev,allow_other 0 0
#(installing Docker)
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get update
sudo apt-get install     ca-certificates     curl     gnupg     lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
#(Docker installed)

cd writeyourbucketname
echo "<h1>Welcome to My Webpage</h1>" > index.html
sudo docker run -d --name nginx-new -p 8080:80 -v /home/ubuntu/writeyourbucketname:/usr/share/nginx/html nginx
#(Now you can check both s3 bucket on AWS and writeyourbucketname in your local)


