FROM ubuntu:focal

ENV DEBIAN_FRONTEND interactive

# install curl and gosu
RUN set -x \
  && apt-get update -qq \
  && apt-get install -qq --no-install-recommends curl ca-certificates net-tools iproute2 gosu neovim git openssh-client \
  && rm -rf /var/lib/apt/lists/*

# install code-server
ARG EDITOR_VERSION
RUN set -x \
  && curl -SLo /tmp/code-server_${EDITOR_VERSION}_amd64.deb https://github.com/cdr/code-server/releases/download/v${EDITOR_VERSION}/code-server_${EDITOR_VERSION}_amd64.deb \
  && dpkg -i /tmp/code-server_${EDITOR_VERSION}_amd64.deb \
  && rm /tmp/code-server_${EDITOR_VERSION}_amd64.deb

# DO NOT REMOVE - partials will be inserted here

# create non-root user
ARG USERNAME=kodadoker
ENV NON_ROOT_USER ${USERNAME}
ARG UID=1000
ARG GID=1000
ARG SHELL=/bin/bash
RUN set -e \
    && groupadd -g ${GID} ${USERNAME} \
    && useradd --create-home --shell ${SHELL} -u ${UID} -g ${USERNAME} ${USERNAME} \
    && usermod -a -G root ${USERNAME}

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]