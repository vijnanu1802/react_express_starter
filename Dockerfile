#
#---Base Node---
#FROM alpine:latest
#RUN apk add --no-cache nodejs npm
#WORKDIR /app
#COPY . /app
#RUN npm install
#EXPOSE 5000
#ENTRYPOINT ["node"]
#CMD ["server.js"]
##----Basenode --

FROM alpine:latest
RUN apk --no-cache nodejs-current tini
WORKDIR /root/chat
ENTRYPOINT ["/sbin/tini", "---"]
COPY package.json .
