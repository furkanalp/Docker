cd widget-factory-inc/
touch Dockerfile
cat Dockerfile #after writing Dockerfile
docker build -t widgetfactory:0.1 .
docker images
export showLayers='{{ range .RootFS.Layers }}{{ println . }}{{end}}'
export showSize='{{ .Size }}'
docker inspect -f "$showSize" widgetfactory:0.1
docker inspect -f "$showLayers" widgetfactory:0.1
docker inspect -f "$showLayers" httpd:2.4 #see difference, we built our image upon that