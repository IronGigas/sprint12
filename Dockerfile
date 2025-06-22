
FROM golang:1.23 AS builder

WORKDIR /app

COPY go.mod go.sum ./

RUN go mod download

COPY *.go ./

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /sprint12 .

FROM alpine:latest

WORKDIR /app

COPY tracker.db .

COPY --from=builder /sprint12 .

CMD ["./sprint12"]
