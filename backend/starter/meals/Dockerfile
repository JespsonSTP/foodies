FROM node:20
WORKDIR /app/src/
COPY package.json .

RUN npm install

COPY . .

EXPOSE 3000

CMD [ "node", "index.js" ]