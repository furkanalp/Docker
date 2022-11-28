docker build -t "widgetfactory:0.2" -f ./Dockerfile .
docker images
docker inspect -f "$showSize" widgetfactory:0.1
docker inspect -f "$showLayers" widgetfactory:0.2
mkdir web && cd web && echo "hello" > index.html && cd ..
docker build -t widgetfactory:0.3 -f ./Dockerfile . #after writing WORKDIR and COPY
docker inspect -f "$showSize" widgetfactory:0.2
docker inspect -f "$showSize" widgetfactory:0.3
docker inspect -f "$showLayers" widgetfactory:0.2
docker inspect -f "$showLayers" widgetfactory:0.3
docker run --rm -it widgetfactory:0.3 bash #see index.html in the container
docker run -d --name web1 -p 80:80 widgetfactory:0.3