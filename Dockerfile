FROM node:14

WORKDIR /app

COPY package.json yarn.lock /app/

RUN yarn install

EXPOSE 7001

CMD bash