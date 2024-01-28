FROM node:18.17.1 as builder
WORKDIR /app/
COPY package*.json /app/
RUN npm install
COPY . /app/
RUN npm run build

FROM nginx:1.23.2
WORKDIR /usr/share/nginx/html
COPY nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /app/build .
RUN chown nginx:nginx -R /usr/share/nginx/html