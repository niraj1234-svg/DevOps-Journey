FROM ubuntu:22.04

LABEL maintainer="Niraj Dhore"

WORKDIR /app

RUN apt-get update && apt-get install -y curl

COPY app.txt /app/

ENV APP_NAME=DockerDemo

EXPOSE 8080

CMD ["sh", "-c", "echo Hello $APP_NAME && cat app.txt"]
