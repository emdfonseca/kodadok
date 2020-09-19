###
# theia build image
###
FROM ubuntu:focal

ENV DEBIAN_FRONTEND interactive

# install build dependencies
RUN mkdir -p /usr/local/theia/node \
  && apt-get update -qq \
  && apt-get install -qq curl ca-certificates build-essential python2 libx11-dev libxkbfile-dev \
  && curl -SLo node-v12.18.3-linux-x64.tar.xz https://nodejs.org/dist/v12.18.3/node-v12.18.3-linux-x64.tar.xz \
  && tar vxJf node-v12.18.3-linux-x64.tar.xz --strip 1 -C /usr/local/theia/node \
  && export PATH="${PATH}:/usr/local/theia/node/bin" \
  && npm install -g yarn 

COPY package.json /usr/local/theia
WORKDIR /usr/local/theia

# build theia
RUN set -x \
  && export PATH="${PATH}:/usr/local/theia/node/bin" \
  && yarn --pure-lockfile \
  && NODE_OPTIONS="--max_old_space_size=4096" yarn theia build \
  && yarn theia download:plugins \
  && yarn --production \
  && yarn autoclean --init \
  && echo *.ts >> .yarnclean \
  && echo *.ts.map >> .yarnclean \
  && echo *.spec.* >> .yarnclean \
  && yarn autoclean --force \
  && yarn cache clean \
  && rm -rf /var/lib/apt/lists/*

###
# theia release image
###
FROM ubuntu:focal

# install curl and gosu
RUN set -x \
  && apt-get update -qq \
  && apt-get install -qq --no-install-recommends curl ca-certificates net-tools iproute2 gosu neovim git openssh-client \
  && rm -rf /var/lib/apt/lists/*

# install code-server and node. node will be depoloyed inside the theia folder
# in order to avoid conflicts with any other node versions
COPY --from=0 /usr/local/theia /usr/local/theia

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

ENV SHELL=/bin/bash
ENV THEIA_DEFAULT_PLUGINS=local-dir:/home/${NON_ROOT_USER}/plugins
ENV USE_LOCAL_GIT true

# DO NOT REMOVE - partials will be inserted here

# cleanup apt
RUN set -x \
  && rm -rf /var/lib/apt/lists/*

EXPOSE 28801
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]