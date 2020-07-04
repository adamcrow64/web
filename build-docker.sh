#!/bin/bash
./mvnw clean package -Dquarkus.container-image.build=true
docker tag adamcrow64/web:1.0.0 crowtech/web:1.0.0
