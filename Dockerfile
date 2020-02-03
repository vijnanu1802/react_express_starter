#
#---Base Node---
FROM alpine:latest

RUN apk add --no-cache nodejs npm

WORKDIR /app

COPY . /app

RUN npm install
ENTRYPOINT ["node"]
EXPOSE : 5000
CMD ["server.js"]

