FROM node:16-alpine AS build
WORKDIR /app

ARG NODE_ENV
ENV NODE_ENV=$NODE_ENV

ARG APP_NAME
ENV APP_NAME=$APP_NAME

ARG APP_PORT
ENV APP_PORT=$APP_PORT

ARG API_PREFIX
ENV API_PREFIX=$API_PREFIX

ARG FRONTEND_DOMAIN
ENV FRONTEND_DOMAIN=$FRONTEND_DOMAIN

ARG BACKEND_DOMAIN
ENV BACKEND_DOMAIN=$BACKEND_DOMAIN

ARG DATABASE_TYPE
ENV DATABASE_TYPE=$DATABASE_TYPE

ARG DATABASE_HOST
ENV DATABASE_HOST=$DATABASE_HOST

ARG DATABASE_PORT
ENV DATABASE_PORT=$DATABASE_PORT

ARG DATABASE_USERNAME
ENV DATABASE_USERNAME=$DATABASE_USERNAME

ARG DATABASE_PASSWORD
ENV DATABASE_PASSWORD=$DATABASE_PASSWORD

ARG DATABASE_NAME
ENV DATABASE_NAME=$DATABASE_NAME

ARG DATABASE_SYNCHRONIZE
ENV DATABASE_SYNCHRONIZE=$DATABASE_SYNCHRONIZE

ARG DATABASE_MAX_CONNECTIONS
ENV DATABASE_MAX_CONNECTIONS=$DATABASE_MAX_CONNECTIONS

ARG DATABASE_SSL_ENABLED
ENV DATABASE_SSL_ENABLED=$DATABASE_SSL_ENABLED

ARG DATABASE_REJECT_UNAUTHORIZED
ENV DATABASE_REJECT_UNAUTHORIZED=$DATABASE_REJECT_UNAUTHORIZED

ARG DATABASE_CA
ENV DATABASE_CA=$DATABASE_CA

COPY package*.json ./
RUN npm install
RUN npm i -g @nestjs/cli
COPY . .

COPY ./startup.prod.sh /opt/startup.prod.sh
RUN sed -i 's/\r//g' /opt/startup.prod.sh
RUN chmod 775 /opt/startup.prod.sh

RUN npm run build
EXPOSE 8080
ENTRYPOINT ["sh","/opt/startup.prod.sh"]