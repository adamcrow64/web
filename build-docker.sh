#!/bin/bash
project=${PWD##*/}
file="src/main/resources/${project}-git.properties"
org=crowtech
function prop() {
  grep "${1}=" ${file} | cut -d'=' -f2
}
version=$(prop 'git.build.version')


./mvnw clean package -Dquarkus.container-image.build=true
docker tag ${USER}/${project}:${version} ${org}/${project}:${version}
docker tag ${USER}/${project}:${version} ${org}/${project}:latest
