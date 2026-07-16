# ---- build: Astro -> static files ----------------------------------
FROM node:22-alpine AS build
WORKDIR /app

COPY package.json package-lock.json ./
RUN npm ci --no-audit --no-fund

COPY . .
RUN npm run build

# ---- runtime: unprivileged nginx serving static files ---------------
FROM nginxinc/nginx-unprivileged:1.29-alpine AS runtime

# Runs as non-root (uid 101) and listens on 8080 by design.
COPY deploy/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget -q -O /dev/null http://127.0.0.1:8080/ || exit 1
