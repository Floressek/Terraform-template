FROM node:20-alpine AS builder
WORKDIR /app
COPY client/package*.json client/pnpm-lock.yaml ./client/

# Install pnpm globally
RUN npm install -g pnpm@10.9.0

# Install dependencies
WORKDIR /app/client
RUN pnpm install

# Copy client source code
COPY client/ ./
COPY server/shared/ ../server/shared/

# Build the Angular application for production
ARG NODE_ENV=development
ENV NODE_ENV=${NODE_ENV}

# Build based on NODE_ENV
RUN if [ "$NODE_ENV" = "production" ]; then pnpm run build; else pnpm run build:dev; fi
FROM nginx:alpine AS production

# Copy built app from builder stage
# Angular outputs to dist/client/browser with the new build system
COPY --from=builder /app/client/dist/client/browser /usr/share/nginx/html
COPY client/nginx.conf /etc/nginx/nginx.conf

EXPOSE 80
CMD ["/bin/sh", "-c", "sed -i \"s|API_URL_PLACEHOLDER|${API_URL:-http://localhost:3000}|g\" /etc/nginx/nginx.conf && nginx -g 'daemon off;'"]
