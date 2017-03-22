FROM node:7

# Used to demonstrate and test https setup for node/express.
# Build container with:
#   docker build -t risingnote/node-docker-test .
# Run container either with:
#   docker run -it --rm --name node-http -p 80:8080 \ 
#        -v /home/me/config-http.json:/usr/app/config/startup.json risingnote/node-docker-test
#   docker run -it --rm --name node-http -p 443:8443 
#        -v /home/me/config-https.json:/usr/app/config/startup.json risingnote/node-docker-test

LABEL name="Node docker demo" \
      description="Demonstrate and test https setup for node / express" \
      maintainer="Jonathan Evans" \
      license="MIT License" 

# Create app directory
RUN mkdir -p /usr/app
WORKDIR /usr/app

# Install app dependencies
COPY package.json /usr/app
RUN npm install

# Bundle app source
RUN mkdir - p /usr/app/src
COPY src /usr/app/src/

# Which will be served depends on 
EXPOSE 8080
EXPOSE 8443

VOLUME /usr/app/config/startup.json

CMD [ "npm", "start" ]