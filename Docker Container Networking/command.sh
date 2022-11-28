#####################Explore the Default Network###################
#List the default networks:
docker network ls
#Run an httpd container named web1, without specifying a network, and see which network it uses:
docker run -d --name web1 httpd:2.4
docker inspect web1
#Take note of the IPAddress.
#Run a container using the busybox image, and see if you can connect to the web1 server:
docker run --rm -it busybox
#Check the container's networking, and verify it is in the same IP range as web1:
ip addr
#Ping the web1 container using the IP address:
ping <WEB1_IP_ADDRESS>
#Attempt to ping the web1 container by name:
ping web1
#Attempt to access web1 using wget:
wget <WEB1_IP_ADDRESS>
#Exit the container:
exit


##########################Explore Bridge Networks###################
#Create a new bridge network named test_application:
docker network create test_application
#Run an httpd container named web2, in the test_application network:
docker run -d --name web2 --network test_application httpd:2.4
#Check the status of the container:
docker ps -a
#Verify that web2 was added to the test_application network:
docker inspect web2
#Run a container using the busybox image, and see if you can connect to the web2 server, within the test_application network:
docker run --rm -it --network test_application busybox
#Check the container's networking, and verify it is in the same IP range as web2:
ip addr
#Ping the web2 container using the IP address:
ping <WEB2_IP_ADDRESS>
#Attempt to ping the web2 container by name:
ping web2
#Using wget, attempt to access web2 with the hostname:
wget web2
#Attempt to ping web1:
ping <WEB1_IP_ADDRESS>
#Attempt to access web1 using wget:
wget <WEB1_IP_ADDRESS>
#Exit the container:
exit


####################Explore the Host Network#################
#Run an httpd container named web3 on the host network:
docker run -d --name web3 --network host httpd:2.4
#Check the status of the container:
docker ps -a
#Attempt to connect to web3 directly from the server:
wget localhost
#Stop web3:
docker stop web3
#Attempt to connect to web3 directly from the server again:
wget localhost
#Start web3:
docker start web3
#Run a container using the busybox image, and see if you can connect to the web3 server:
docker run --rm -it --network host busybox
ping web3
#Using wget, attempt to access localhost within the busybox image:
wget localhost
#Attempt to ping web2:
ping <WEB2_IP_ADDRESS>
#Attempt to ping web1:
ping <WEB1_IP_ADDRESS>
exit
docker stop $(docker ps -q)
docker rm $(docker ps -a -q)