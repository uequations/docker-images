Glassfish on Docker
===============
Sample Docker configurations to facilitate installation, configuration, and environment setup for DevOps users.

## How to build and run
docker run -d -p 4848:4848 -p 8080:8080 -p 8181:8181 -p 9009:9009 --restart=always --name [NAME] [IMAGE]
