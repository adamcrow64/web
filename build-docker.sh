#!/bin/bash
org=crowtech
version=$(prop 'git.build.version')
project=${PWD##*/}
file="src/main/resources/${project}-git.properties"

function prop() {
  grep "${1}=" ${file} | cut -d'=' -f2
}

./mvnw clean package -Dquarkus.container-image.build=true
docker tag ${USER}/${project}:${version} ${org}/${project}:${version}
