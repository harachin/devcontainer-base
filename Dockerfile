FROM ubuntu:24.04

ARG GIT_COMPLETION_URL=https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
ARG GIT_PROMPT_URL=https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
ARG HADOLINT_URL=https://github.com/hadolint/hadolint/releases/download/v2.12.0/hadolint-Linux-x86_64
ARG USER=developer
ARG UID=1001
ARG GID=1001
ARG HOMEDIR=/home/${USER}

# Set developer user.
RUN groupadd -g ${GID} ${USER} && \
    useradd -m -u ${UID} -g ${GID} -s /bin/bash -l ${USER}

# Install packages
RUN apt-get update && apt-get install --no-install-recommends -y \
    ca-certificates \
    locales \
    language-pack-ja \
    git \
    gnupg2 \
    curl \
    wget \
    vim \
    less \
    zip \
    unzip && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install hadolint
RUN wget ${HADOLINT_URL} -q -O /usr/local/bin/hadolint && \
    chmod +x /usr/local/bin/hadolint

# Install git-completion
RUN wget ${GIT_COMPLETION_URL} -q -O ${HOMEDIR}/.git-completion.bash && \
    wget ${GIT_PROMPT_URL} -q -O ${HOMEDIR}/.git-prompt.sh

# Set Timezone to JST
RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

# Set locale
RUN locale-gen ja_JP.UTF-8
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV LC_ALL ja_JP.UTF-8

# Set bashrc
COPY ./dotfiles/* ${HOMEDIR}
RUN chown ${USER}:${USER} ${HOMEDIR} -R

USER ${USER}

WORKDIR ${HOMEDIR}

CMD ["/bin/bash"]
