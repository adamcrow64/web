#!/bin/bash
version=$(prop 'git.build.version')
project=${PWD##*/}
file="src/main/resources/notes-git.properties"

function prop() {
  grep "${1}=" ${file} | cut -d'=' -f2
}

if [ -z "${1}" ]; then
  version="latest"
else
  version="${1}"
fi

if [ -f "$file" ]; then
  echo "$file found."
  echo "git.commit.id = " "$(prop 'git.commit.id')"
  echo "git.build.version = " "$(prop 'git.build.version')"

  docker push crowtech/${project}:"${version}"

  docker tag crowtech/${project}:"${version}" crowtech/${project}:latest
  docker push crowtech/${project}:latest

  docker tag crowtech/${project}:"${version}" crowtech/${project}:"$(prop 'git.build.version')"
  docker push crowtech/${project}:"$(prop 'git.build.version')"
else
  echo "ERROR: git properties $file not found."
fi
