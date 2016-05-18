# Dockerfile
FROM ubuntu:latest

# Replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Run updates and install deps
RUN apt-get update
RUN apt-get install -y curl \
    git \
    make \
    nginx \
    sudo

ENV WORK_DIR /app/keystone-app
ENV NVM_DIR /root/.nvm
ENV NODE_VERSION 5.5.0

# Install nvm with node and npm
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.0/install.sh | bash \
    && source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

# Set up our PATH correctly so we don't have to long-reference npm, node, &c.
ENV NODE_PATH $NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# Set the work directory
RUN mkdir -p $WORK_DIR
WORKDIR $WORK_DIR

# Add our package.json and install *before* adding our application files
ADD package.json ./
RUN npm i --production
RUN npm i -g pm2

# Add application files
ADD . $WORK_DIR

# Expose the port
EXPOSE 3000

# The --no-daemon is a minor workaround to prevent the docker container from thinking pm2 has stopped running and ending itself
CMD ["pm2", "start", "process.json", "--no-daemon"]
