# Omeka on Docker

This starter kit aims to run a fresh Omeka framwork in a sec build on top of:
* Debian Jessie
* Nginx
* PHP7
* MariaDB

## Requirements
* Docker
* Docker-compose

## Init
**1 - Clone this repo**
```
$ git clone https://github.com/soifou/docker-omeka
```

**2 - Get a release from Omeka**
```sh
$ git clone https://github.com/omeka/Omeka/ omeka-src
$ cd omeka-src
$ git checkout v2.5
```

**3 - Launch the containers**
In the root directory:
```sh
$ docker-compose up -d
```

**4 - Create an omeka database**
```
$ docker exec -it omeka_db mysql -uroot -proot -e "create database omeka"
```

Goto: [http://localhost:8088/install/install.php](http://localhost:8088/install/install.php) to finish the install process.

Done!