FROM alpine:latest

COPY . .

RUN chmod +x /docker-entrypoint.sh

RUN apk add --update --no-cache bash bind-tools bind

ENTRYPOINT ["/docker-entrypoint.sh"]
