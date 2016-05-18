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
```bash
docker run -v "$(pwd)":/data --name mongo-service -d mongo mongod --smallfiles
```
* Launch Keystone
```bash
docker run -p 80:3000 --link mongo-service:mongo -d --name keystone-app docker-keystone
```