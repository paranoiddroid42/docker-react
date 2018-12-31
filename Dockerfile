FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
EXPOSE 80 
# to instruct aws to expose port 80, does nothing on a localhost build
COPY --from=builder /app/build /usr/share/nginx/html
#no need to run nginx as default is to run