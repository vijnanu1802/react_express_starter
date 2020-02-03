#
#---Base Node---
FROM apline:latest

RUN apk add --no-cahe nodejs npm

WORKDIR /app

COPY . /app

RUN npm install

