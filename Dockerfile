# Base image
FROM node:20-alpine as builder

# Set working directory
WORKDIR /app

# Utilize Docker cache to save re-installing dependencies if unchanged
COPY package*.json ./


RUN npm install


COPY . .


RUN npm run build


FROM nginx:stable-alpine

COPY --from=builder /app/public /usr/share/nginx/html

EXPOSE 80

CMD [ "nginx", "-g", "daemon off;" ]