# codex-devlab.github.io

[![Build Status](https://img.shields.io/endpoint.svg?url=https%3A%2F%2Factions-badge.atrox.dev%2Fcodex-devlab%2Fcodex-devlab.github.io%2Fbadge%3Fref%3Dmain&style=flat)](https://actions-badge.atrox.dev/codex-devlab/codex-devlab.github.io/goto?ref=main) ![Repository Size](https://img.shields.io/github/repo-size/codex-devlab/codex-devlab.github.io) ![Contributor](https://img.shields.io/github/contributors/codex-devlab/codex-devlab.github.io) ![Last Commit](https://img.shields.io/github/last-commit/codex-devlab/codex-devlab.github.io) ![License](https://img.shields.io/github/license/codex-devlab/codex-devlab.github.io) ![Open Issues](https://img.shields.io/github/issues/codex-devlab/codex-devlab.github.io?color=important) ![Open Pull Requests](https://img.shields.io/github/issues-pr/codex-devlab/codex-devlab.github.io?color=yellowgreen) ![Security Headers](https://img.shields.io/security-headers?url=https%3A%2F%2Fcodex-devlab.github.io%2F) [![This project is using Percy.io for visual regression testing.](https://percy.io/static/images/percy-badge.svg)](https://percy.io/b7cb60ab/codex-devlab.github.io)


## Run with docker


* Dockerfile  
    ```dockerfile
    # specify the node base image with your desired version node:<version>

    FROM alpine:3.20
    MAINTAINER codex <codex@innogrid.com>

    ARG EXPOSE_PORT=8081

    RUN apk update
    RUN apk add --no-cache build-base \
            git \
            gcc \
            nodejs-current \
            npm \
            go
    RUN apk add --no-cache --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community hugo
    EXPOSE 8081
    ENV HUGO_BIND=0.0.0.0 HUGO_DESTINATION=public HUGO_ENV=DEV HUGO_EDITION=extended

    RUN mkdir /app
    ADD entrypoint.sh /app/entrypoint.sh
    RUN chmod 777 /app/entrypoint.sh
    RUN echo "Installing base packages" \
            && apk add --update --no-cache \
                    socat \
            && echo "Removing apk cache" \
            && rm -rf /var/cache/apk/
    RUN mkdir -p /data/public && cd /data/public
    ENTRYPOINT ["/app/entrypoint.sh"]
    ```

  * Entrypoint.sh  
    ```shell
    #!/bin/sh
    #
    echo "Hugo Start!"
    cd /data/public; 
    hugo mod tidy
    hugo mod npm pack
    npm install
    hugo --minify
    hugo  server -N -w -D --bind 0.0.0.0  --port 8001 --baseURL http://localhost:8001/
    ```


* Docker Compose  
    ```yaml
    services:
    web:
        image: 'hugo:1.3'
        restart: always
        hostname: 'hugo'
        container_name: hugo
        ports:
        - 8001:8001
        volumes:
        - /home/hugo/blog:/data/public
        # When you using Customed Theme
        #- /home/hugo/customs_theme:/data/customs_theme
    ```

* Docker run  
    ```shell
    docker run -itd -p 8001:8001 --name hugo -v /home/codex/git/personal/blog:/data/public --entrypoint /bin/sh hugo:1.3
    ```