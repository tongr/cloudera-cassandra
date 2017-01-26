#! /bin/bash

git clone "https://github.com/cloudera/cm_ext" ./cm_ext

cd ./cm_ext
mvn package
cd ..
