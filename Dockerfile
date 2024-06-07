# Use an amd64 architecture base image
FROM --platform=linux/amd64 ubuntu:20.04
ARG DEBIAN_FRONTEND=noninteractive
# Install dependencies
RUN apt-get update && \
    apt-get install -y software-properties-common curl git bzip2 openjdk-11-jre && \
    apt-get install -y make gcc
# Install Python 3.12.3
RUN apt-get update && \
    apt-get install -y wget build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl && \
    wget https://www.python.org/ftp/python/3.12.3/Python-3.12.3.tgz && \
    tar xzf Python-3.12.3.tgz && \
    cd Python-3.12.3 && \
    ./configure --enable-optimizations && \
    make altinstall && \
    cd .. && \
    rm -rf Python-3.12.3 Python-3.12.3.tgz
# Install Mamba (a faster alternative to Conda)
RUN curl -fsSL https://micromamba.snakepit.net/api/micromamba/linux-64/latest | tar -xvj -C /opt && \
    /opt/bin/micromamba shell init -s bash -p /opt/conda
# Update PATH
ENV PATH /opt/conda/bin:/opt/bin:$PATH
# Create a new environment and install Bactopia version 3.0.1 using Mamba
RUN /opt/bin/micromamba create -y -n bactopia -c conda-forge -c bioconda bactopia=3.0.1
# Install Nextflow
RUN curl -s https://get.nextflow.io | bash && \
    mv nextflow /usr/local/bin/
# Activate Bactopia environment
SHELL ["/opt/bin/micromamba", "run", "-n", "bactopia", "/bin/bash", "-c"]
# Install additional Bactopia dependencies if needed
RUN bactopia --help
# Set the entrypoint
ENTRYPOINT ["/opt/bin/micromamba", "run", "-n", "bactopia", "bactopia"]
