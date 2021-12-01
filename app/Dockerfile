FROM node:16 as base

WORKDIR /app
COPY package*.json ./
EXPOSE 3000

FROM base as production
ENV NODE_ENV=production
RUN npm ci
RUN npm i -g pm2
COPY . .
CMD ["pm2-runtime", "ecosystem.config.js"]

FROM base as development
ENV NODE_ENV=development
RUN npm i
RUN ls -la
COPY . .

CMD ["npm", "start"]
