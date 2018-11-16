# BUILDER
FROM golang:alpine AS builder
RUN apk update && apk add git && apk add bash

COPY deps.sh . 
RUN bash -c './deps.sh'

COPY . .
RUN go build -o /deploy/votingapp && cp -r ui /deploy

# RUNTIME
FROM ubuntu:18.04
WORKDIR /app

COPY --from=builder /deploy .
ENTRYPOINT [ "./votingapp" ]