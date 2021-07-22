FROM node:14

WORKDIR /usr/src/app
COPY $PWD/node_app/package.json  $PWD/node_app/app.js ./
RUN npm install
EXPOSE 3000
CMD ["node", "app.js"]
