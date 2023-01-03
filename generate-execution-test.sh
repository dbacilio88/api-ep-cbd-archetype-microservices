#!/usr/bin/env bash

PWD=$(pwd)
FOLDER_TEST_CASE="testing-project"
ARCHETYPE_VERSION="1.0.0"

echo ":: Cleanup folder"
[ -d ${FOLDER_TEST_CASE} ] && rm -rf ${FOLDER_TEST_CASE}

echo ":: Create folder for test"
mkdir ${FOLDER_TEST_CASE}
cd ${FOLDER_TEST_CASE}

echo ":: Generate project with archetype version [${ARCHETYPE_VERSION}]"
mvn archetype:generate \
  -DarchetypeGroupId=ep.mil.microservices.archetypes \
  -DarchetypeArtifactId=api-ep-cbd-archetype-microservices \
  -DarchetypeVersion=${ARCHETYPE_VERSION} \
  -DgroupId=com.novo.microservices \
  -DartifactId=api-ncc-accounts-microservice \
  -Dversion=1.0.0 \
  -DinteractiveMode=false

echo ":: Build project"
cd "api-ncc-accounts-microservice"
sh gradlew clean build -x test -x spotbugsTest -x :spotbugsMain

echo ":: Finish generation"
cd ${PWD}