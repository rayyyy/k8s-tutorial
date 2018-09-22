FROM node:latest

RUN npm install -g vue-cli
WORKDIR /root
RUN git clone https://github.com/rayyyy/nuxt_app.git
WORKDIR /root/nuxt_app
RUN npm i
ENTRYPOINT ["npm", "run", "dev"]