#!/usr/bin/env bash

APP_NAME=reactnativeapp
docker build . -f Dockerfile -t $APP_NAME && \
docker run --name react-native-app -it -p 7001:7001 --rm -v ${PWD}:/app -v ${APP_NAME}_nodemodules:/app/node_modules $APP_NAME $@