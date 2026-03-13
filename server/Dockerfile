FROM node:20-alpine AS base
WORKDIR /app
RUN npm install -g pnpm@10.9.0

# Build
FROM base AS builder
WORKDIR /app/server
COPY server/package*.json server/pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile
COPY server/ ./
RUN pnpm run build

# Production
FROM node:20-alpine AS production
RUN npm install -g pnpm@10.9.0
WORKDIR /app

COPY --from=builder /app/server/package*.json /app/server/pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile --prod

COPY --from=builder /app/server/dist ./dist

# Cloud RUN
ENV PORT=3000
EXPOSE 3000

CMD ["node", "dist/src/main.js"]
