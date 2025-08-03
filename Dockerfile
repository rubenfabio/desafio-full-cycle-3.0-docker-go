FROM golang:1.24.4-alpine AS builder

WORKDIR /app

COPY go.mod ./
COPY go.sum ./

COPY hello.go .

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -ldflags="-s -w" -o hello .

FROM scratch

WORKDIR /app

COPY --from=builder /app/hello .

CMD ["./hello"]
