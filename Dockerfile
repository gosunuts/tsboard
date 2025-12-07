# Stage 1: build Vue frontend
FROM node:22-bookworm-slim AS frontend-builder
WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm ci

# Build assets
COPY . .
RUN npm run build

# Stage 2: nginx image serving the built assets
FROM nginx:1.27-alpine AS frontend
WORKDIR /usr/share/nginx/html

COPY docker/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=frontend-builder /app/dist ./

# Uploads shared with goapi
RUN mkdir -p /usr/share/nginx/html/upload

# Stage 3: goapi runtime
FROM debian:bookworm-slim AS goapi
WORKDIR /app

RUN apt-get update \
  && apt-get install -y --no-install-recommends ca-certificates libvips \
  && rm -rf /var/lib/apt/lists/*

COPY goapi-linux-x86 ./goapi-linux-x86
COPY docker/goapi-entrypoint.sh ./entrypoint.sh
RUN chmod +x ./goapi-linux-x86 ./entrypoint.sh

EXPOSE 3003
CMD ["./entrypoint.sh"]
