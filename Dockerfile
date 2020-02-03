#
#---Base Node---
FROM apline:3.5

RUN apk add --no-cahe nodejs npm

WORKDIR /app

COPY . /app

RUN npm install

