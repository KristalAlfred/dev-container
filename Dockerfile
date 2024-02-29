FROM debian:stable-slim

RUN apt-get update 

####
## Install Docker
####
RUN apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release 

RUN mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg

RUN echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

RUN apt-get update && apt-get install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-compose-plugin

####
## Install various tools
####
RUN apt-get install -y \
    build-essential \
    tmux \
    curl \
    git \
    python3 \
    rustfmt \
    gdb \
    gh \
    htop \
    ncdu \
    httpie \
    tcpdump \
    strace \
    sudo \
    lsof \
    jq \
    yq \
    wget 

####
## Install Rustup
####
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

RUN wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh
RUN chmod +x ./dotnet-install.sh
RUN ./dotnet-install.sh --version latest

####
## Install Neovim
####
RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
RUN sudo rm -rf /opt/nvim
RUN sudo tar -C /opt -xzf nvim-linux64.tar.gz
ENV PATH="$PATH:/opt/nvim-linux64/bin"

####
## Do runtime config
####
COPY gh-auth.sh /gh-auth.sh
RUN chmod +x gh-auth.sh

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
