docker info
systemctl status docker
docker images
docker image pull ubuntu
docker run -it ubuntu
docker image pull ubuntu:18.04
docker inspect ubuntu
docker inspect ubuntu:18.04
docker search ubuntu
mkdir first_web && cd first_web

echo '
from flask import Flask
app = Flask(__name__)
@app.route("/")
def hello():
    return "<h1>Welcome to my Page</h1>"
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=80)
' > welcome.py

cat welcome.py
docker build -t "furkanalp/flask-app:1.0" . # after writing Dockerfile
docker image ls
docker run -d --name welcome -p 80:80 furkanalp/flask-app:1.0
docker run -d --name welcome2 -p 8080:80 furkanalp/flask-app:1.0
docker login # give your credentials of your Dockerhub account
docker push furkanalp/flask-app:1.0

docker build -t "furkanalp/flask-app:2.0" -f ./Dockerfile-alpine . # after writing Dockerfile-alpine
docker run -d --name myimage -p 8080:80 furkanalp/flask-app:2.0
docker push furkanalp/flask-app:2.0
docker image tag furkanalp/flask-app:2.0 furkanalp/flask-app:latest
docker stop $(docker ps -q)
docker rm $(docker ps -a -q)
docker image ls