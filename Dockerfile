#
#---Base Node---
FROM alpine:latest as base
RUN apk add --no-cache nodejs npm
WORKDIR /app

COPY . /app
#RUN pwd
#RUN ls -ltr ./

#RUN rm -rf node_modules 

RUN npm cache clear --force
RUN npm install -g npm@next
#RUN chmod -R 777 ./node_modules
RUN ls -ltra
#RUN npm run client-install debug
#RUN npm run dev debug

#RUN npm run server debug
### nenu rasthuna###
#WORKDIR /usr/src/app
#COPY package*.json ./
#COPY server*.js ./

#RUN npm install  express --save
#RUN chmod -R 777 *
#COPY . .
#RUN npm --verbose install
#RUN npm run build
#RUN npm --verbose run client-install
#RUN chmod -R 777 *
#RUN npm run dev
EXPOSE 5000
ENTRYPOINT ["node", "npm start"]
#RUN npm run client
CMD ["server.js"]
RUN npm run dev debug
RUN npm run server debug
##----Basenode --

   

# ---- Dependencies ----
FROM base AS dependencies
# install node packages
RUN npm set progress=false && npm config set depth 0
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
FROM dependencies AS test
COPY . /app
RUN ls -ltr 
#RUN npm install -g firebase-tools
RUN npm run setup 
 
#
# ---- Release ----
FROM base AS release
# copy production node_modules
#COPY --from=dependencies /client/prod_node_modules ./node_modules
copy /app sources
COPY . .
# expose port and define CMD
EXPOSE 5000
CMD npm run start
  
