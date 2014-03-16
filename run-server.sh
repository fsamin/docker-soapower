#!/bin/sh

docker run -i -d -p 3306:13306 -p 9010:19010 -p 2244:22 -v /data/mysql:/var/lib/mysql fsamin/soapower 
