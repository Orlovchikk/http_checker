FROM ubuntu:22.04

RUN apt update \
    && apt install -y curl && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY part1/http_checker.sh .

CMD [ "bash", "http_checker.sh" ]