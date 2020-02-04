#
#---Base Node---
FROM alpine:latest
RUN apk add --no-cache nodejs npm
RUN mkdir client 
#WORKDIR client
COPY package.json .
RUN npm install
RUN npm run client-install 

RUN npm run dev
RUN npm run server

 
EXPOSE 5000
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
