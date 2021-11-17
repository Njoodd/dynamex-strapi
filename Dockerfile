FROM node:14-alpine

ENV PORT 1337
ENV HOST 0.0.0.0
ENV NODE_ENV production
ENV DATABASE_HOST=mysql
ENV DATABASE_CLIENT=mysql
ENV DATABASE_PORT=3306
ENV DATABASE_NAME=strapi
ENV DATABASE_USERNAME=strapi
ENV DATABASE_PASSWORD=strapi

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY package*.json /usr/src/app/
COPY yarn.lock /usr/src/app/
COPY node_modules /usr/src/app/
COPY build /usr/src/app/
COPY api /usr/src/app/
COPY config /usr/src/app/
COPY public /usr/src/app/
COPY extensions /usr/src/app/
COPY favicon.ico /usr/src/app/

RUN yarn install
RUN NODE_ENV=${NODE_ENV} yarn build

EXPOSE ${PORT}
ENTRYPOINT ["NODE_ENV=${NODE_ENV} ","yarn", "start"]