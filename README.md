# react-native-docker-starter
A React Native + NodeJS in a Docker


## Initial Config

### 1. Create Dockerfile.init with contents:

FROM node:14

WORKDIR /app

CMD bash

### 2. Build node docker image

docker build . -f Dockerfile.init -t reactnativeapp

### 3. Create react native project

??? docker run -it --rm -v ${PWD}/reactnativeapp:/app reactnativeapp yarn init
docker run -it --rm -v ${PWD}/reactnativeapp:/app reactnativeapp yarn add expo
docker run -it --rm -v ${PWD}/reactnativeapp:/app reactnativeapp yarn run expo init reactnativeapp .

### 4. Change app folder permissions - probably owned by root

sudo chown -R ${USER} reactnativeapp

### 5. Delete node_modules folder to avoid platform conflicts

rm -rf node_modules


## Development Config

### 1. Create ./reactnativeapp/Dockerfile with contents to run app from local directory:

FROM node:14

WORKDIR /app

COPY package.json yarn.lock /app/

RUN yarn install

EXPOSE 7001

CMD bash

### 2. Create ./reactnativeapp/start.sh script with contents:

\#!/usr/bin/env bash
APP_NAME=reactnativeapp
docker build . -f Dockerfile -t ${APP_NAME} && \
docker run --name="react-native-app" -p 7001:7001 -it --rm -v ${PWD}:/app -v ${APP_NAME}_nodemodules:/app/node_modules $@

### 3. Instll env again

????? bash start.sh yarn init
bash start.sh yarn add expo
bash start.sh yarn run expo init reactnativeapp .

### 4. Run environment

bash start.sh yarn start

### 5. Edit reactnativeapp/src/App.js and enjoy the automatic reloading

vim reactnativeapp/src/App.js


## Maintenance

### 1. Add some library

bash run.sh yarn add styled-components

### 2. Build project

bash run.sh yarn build

### 3. Cleanup

docker image rm reactnativeapp
docker volume rm reactnativeapp_nodemodules

Overall Docker cleanup

docker network prune
docker volume prune
docker image prune
