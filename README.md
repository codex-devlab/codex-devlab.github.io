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
            wget

    WORKDIR ~/
    RUN wget https://go.dev/dl/go1.23.1.linux-amd64.tar.gz
    RUN rm -rf /usr/local/go
    RUN tar -C /usr/local -xzf go1.23.1.linux-amd64.tar.gz && rm -rf go1.23.1.linux-amd64.tar.gz
    ENV PATH="${PATH}:/usr/local/go/bin"
    RUN apk add --no-cache --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community hugo
    ENV HUGO_BIND=0.0.0.0 HUGO_DESTINATION=public HUGO_ENV=DEV HUGO_EDITION=extended
    WORKDIR ~/
    RUN git clone https://github.com/gohugoio/hugo.git
    WORKDIR ~/hugo
    RUN CGO_ENABLED=1 go install -tags extended github.com/gohugoio/hugo@latest
    RUN hugo version && rm -rf ~/hugo
    RUN mkdir /app
    ADD entrypoint.sh /app/entrypoint.sh
    RUN chmod 777 /app/entrypoint.sh
    RUN echo "Installing base packages" \
            && apk add --update --no-cache \
                    socat \
            && echo "Removing apk cache" \
            && rm -rf /var/cache/apk/
    RUN mkdir -p /data/public && cd /data/public
    EXPOSE 8081
    ENTRYPOINT ["/app/entrypoint.sh"]
    ```

  * Entrypoint.sh  
    ```shell
    #!/bin/sh
    # Resolve Git "dubious ownership" error caused by volume mount
    git config --global --add safe.directory /data/public
    echo "Hugo Start!"
    cd /data/public;
    hugo mod tidy
    hugo mod npm pack
    npm install
    # Build the site with minified HTML/CSS/JS for production deployment
    # OR the site and launch a local static server to verify SEO-related files (e.g., sitemap.xml, robots.txt)
    hugo --minify
    # Run Hugo development server with drafts enabled for live preview
    hugo  server -N -w -D --bind 0.0.0.0  --port 8001 --baseURL http://localhost:8001/
    ```


* Docker Compose  
    ```yaml
    services:
    web:
        image: 'hugo:1.4'
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
    docker run -itd -p 8001:8001 --name hugo -v /home/hugo/blog:/data/public --entrypoint /bin/sh hugo:1.4
    ```