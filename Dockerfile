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

FROM alpine:latest AS base
RUN apk add --no-cache nodejs-current tini
WORKDIR client
#ENTRYPOINT ["/sbin/tini", "---"]
COPY package.json .


# ---- Dependencies ----
FROM base AS dependencies
# install node packages
#RUN npm set progress=false && npm config set depth 0
RUN npm install --only=dev
# copy production node_modules aside
RUN cp -R node_modules prod_node_modules
# install ALL node_modules, including 'devDependencies'
RUN npm install
 
#
# ---- Test ----
# run linters, setup and tests
FROM dependencies AS test
COPY . .
RUN  npm run lint && npm run setup && npm run test
 
#
# ---- Release ----
FROM base AS release
# copy production node_modules
COPY --from=dependencies /client/prod_node_modules ./node_modules
# copy app sources
COPY . .
# expose port and define CMD
EXPOSE 5000
CMD npm run start
