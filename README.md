#Docker Keystone

Installation
-------------------

* Build the image
```bash
docker build -t docker-keystone .
```

Quick Start
-------------------

* Launch MongoDB container
* The ```-v /datadir:/data/db``` part of the command mounts the ```/datadir``` directory from the underlying host system as ```/data/db``` inside the container, where MongoDB by default will write its data files.
```bash
docker run -v /datadir:/data/db --name mongo-service -d mongo mongod --smallfiles
```
* Launch Keystone
```bash
docker run -p 80:3000 --link mongo-service:mongo -d --name keystone-app docker-keystone
```
