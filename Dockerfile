# general idea is this is a two phase process.
# first we build our website static files in one container
# second we copy over files to an nginx container that will be able to serve them as a web server

# builder phase block
FROM node:alpine as builder   
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
# npm run build will create in /app/build <-- all our stuff for website
RUN npm run build    

# new FROM terminates last block and starts new Run phase block which has our new base image nginx         
FROM nginx 
# copy something over from builder phase to new html folder
COPY --from=builder  /app/build /usr/share/nginx/html  


