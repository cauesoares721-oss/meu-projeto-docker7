FROM node:20-alpine AS builder

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

FROM node:20-alpine

WORKDIR /app

COPY --from=builder /app .

RUN addgroup -S appgroup && \
    adduser -S appuser -G appgroup && \
    mkdir ´p /etc/todos && \
    chown -R appuser:appgroup /app /etc/todos

EXPOSE 3000

USER appuser

CMD ["node", "src/index.js"]
