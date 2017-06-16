FROM golang:1.8.3 as builder
WORKDIR /go/src/github.com/acastle/esperbot
COPY . .
RUN go get \
  && GO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .

FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=builder /go/src/github.com/acastle/esperbot/app .
CMD ["./app"]
