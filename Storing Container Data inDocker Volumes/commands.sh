##########Discover Anonymous Docker Volumes###############
#Check the docker images:
docker images
#Run a container using the postgres:12.1 repository:
docker run -d --name db1 postgres:12.1
#Run a second container using the same image:
docker run -d --name db2 postgres:12.1
#Check the status of the containers:
docker ps
#List the anonymous volumes:
docker volume ls
#Inspect the db1 container:
docker inspect db1 -f '{{ json .Mounts }}' | python -m json.tool
#Inspect the db2 container:
docker inspect db2 -f '{{ json .Mounts}}' | python -m json.tool
#Create a third container using the --rm flag:
docker run -d --rm --name dbTmp postgres:12.1
#Check the status of the container:
docker ps -a
#List the anonymous volumes:
docker volume ls
#Stop the db2 and dbTmp containers:
docker stop db2 dbTmp
#List the anonymous volumes:
docker volume ls
#Check the status of the containers:
docker ps -a


####################Create a Docker Volume############################
#Create a Docker volume:
docker volume create website
#Verify that the volume was created successfully:
docker volume ls
#Copy the widget-factory-inc data to the website container:
sudo cp -r /home/cloud_user/widget-factory-inc/web/* /var/lib/docker/volumes/website/_data/
#List the copied data:
sudo ls -l /var/lib/docker/volumes/website/_data/


#####################Use the Website Volume with Containers########################
#Run a docker container with the website volume:
docker run -d --name web1 -p 80:80 -v website:/usr/local/apache2/htdocs:ro httpd:2.4
#Check the status of the container:
docker ps
#In a web browser, verify connectivity to the container:
<PUBLIC_IP_ADDRESS>
#Run a second container with the --rm flag:
docker run -d --name webTmp --rm -v website:/usr/local/apache2/htdocs:ro httpd:2.4
#Check the status of the containers:
docker ps
#Stop the webTmp container:
docker stop webTmp
#Check the status of the containers:
docker ps -a
#Verify that the website can still be accessed through a web browser:
<PUBLIC_IP_ADDRESS>


########################Clean Up Unused Volumes###########################
#Clean up the unused volumes:
docker volume prune
#Check the currently running containers:
docker ps -a
#Remove the db2 container:
docker rm db2
#Clean up the unused volumes again:
docker volume prune
#List the current volumes:
docker volume ls


############################Back Up and Restore the Docker Volume##########################
#Switch to the root user:

sudo -i
#Find where the website volume data is stored:

docker volume inspect website
#Copy the Mountpoint.

#Back up the volume:

tar czf /tmp/website_$(date +%Y-%m-%d-%H%M).tgz -C /var/lib/docker/volumes/website/_data .
#Verify that the data was backed up properly:

ls -l /tmp/website_*.tgz
#List the contents of the tgz file:

tar tf <BACKUP_FILE_NAME>.tgz
#Exit out of root:

exit
#Run a new container using the website volume, and create a backup:

docker run -it --rm -v website:/website -v /tmp:/backup bash tar czf /backup/website_$(date +%Y-%m-%d-%H-%M).tgz -C /website .
#Verify that the data was backed up properly:

ls -l /tmp/website_*.tgz
#Switch to the root user:

sudo -i
#Change to the /docker/volumes/ directory:

cd /var/lib/docker/volumes/
#List the volumes:

ls -l
#Change to the website/_data directory:

cd website/_data/
#Remove the contents of the directory:

rm * -rf
#Verify that the backups are still available:

ls -l /tmp/website_*.tgz
#Restore the data to the current directory:

tar xf /tmp/<BACKUP_FILE_NAME>.tgz .

#Verify that the data was restored successfully:

ls -l