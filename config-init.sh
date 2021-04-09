#!/usr/bin/env bash -x

docker build . -f Dockerfile.init -t reactnativeapp
docker run -it --rm -v ${PWD}/reactnativeapp:/app reactnativeapp yarn add expo
docker run -it --rm -v ${PWD}/reactnativeapp:/app reactnativeapp yarn run expo init reactnativeapp .
sudo chown -R ${USER} reactnativeapp
rm -rf node_modules