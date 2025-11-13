FROM golang:1.24-alpine AS builder
WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o /consumer ./cmd/consumer

FROM alpine:latest
WORKDIR /root/

COPY --from=builder /consumer /cmd/consumer
EXPOSE 8080
CMD ["/cmd/consumer"]