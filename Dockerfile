FROM node:alpine AS builder

WORKDIR '/app'

COPY package.json .
RUN npm install
COPY . .

RUN npm run build

# By using FROM, we terminate the previous phase

FROM nginx

# Copy from another phase (here : builder)
# Specify where we want to copy the stuff to
COPY --from=builder /app/build /usr/share/nginx/html

# Default command of nginx start it automatically