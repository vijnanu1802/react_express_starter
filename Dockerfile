#
#---Base Node---
FROM alpine:latest
RUN apk add --no-cache nodejs npm
#RUN mkdir /home/vijnan
#WORKDIR /home/vijnan

#COPY package.json /client/
#COPY * /client/
#COPY package.json ./
#RUN mkdir ./client
#RUN cp -R client/ ./
#RUN cp -R package.json ./
#RUN cp -R server.js ./

RUN pwd
RUN ls -ltr ./
#RUN ls -ltr /var/lib/jenkins/workspace/docker-node
#RUN echo $WORKDIR
#RUN cp package.json $WORKDIR/
COPY package.json ./
COPY server.js ./
#COPY client/ ./
RUN ls -ltra
RUN mkdir client
COPY package.json ./client/
COPY server.js ./client/
RUN rm -rf node_modules 
RUN npm cache clear --force
RUN npm install
RUN npm run client-install
RUN npm run dev

RUN npm run server

 
EXPOSE 5111
ENTRYPOINT ["node", "npm start"]
#RUN npm run client
CMD ["server.js"]
##----Basenode --

   

# ---- Dependencies ----
#FROM base AS dependencies
# install node packages
#RUN npm set progress=false && npm config set depth 0
#WORKDIR /client
#RUN [concurrently: 4.1.1,
#    express: 4.17.1,
 #   nodemon: 1.19.1 ]
# copy production node_modules aside
#RUN cp -R node_modules prod_node_modules
# install ALL node_modules, including 'devDependencies'
#RUN apt-get update && apt-get install -y curl 
#RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -

 
#
# ---- Test ----
# run linters, setup and tests
#FROM dependencies AS test
#COPY . .
#RUN  npm run lint && npm run setup && npm run test
 
#
# ---- Release ----
#FROM base AS release
# copy production node_modules
#COPY --from=dependencies /client/prod_node_modules ./node_modules
# copy app sources
#COPY . .
# expose port and define CMD
#EXPOSE 5000
#CMD npm run start
