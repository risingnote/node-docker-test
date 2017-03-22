FROM node:7

# Used to demonstrate and test https setup for node/express.
# Build container with:
#   docker build -t risingnote/node-docker-test .
# Run container with:
#   docker run -it --rm --name node-http -p 443:8443 \ 
#        -v /home/me/config:/usr/app/config risingnote/node-docker-test

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

VOLUME /usr/app/config

CMD [ "npm", "start" ]