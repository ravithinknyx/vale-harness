ARG FROM=ubuntu:22.04
FROM ${FROM}

ARG DEBIAN_FRONTEND=noninteractive
ARG VALE_VERSION="2.20.1"


# Labels.
LABEL maintainer="iat@statestr.com" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.description="Vale Docker Image " \
    org.label-schema.vendor="SSC" \
    org.label-schema.docker.cmd="docker run -it --entrypoint /bin/bash vale-base:v1.0.0"

#  Link Bash to SH

RUN ln -sf /bin/bash /bin/sh

# Update Base Image With Required Packages

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get install -y \
        curl \
        unzip \
        apt-transport-https \
        ca-certificates \
        software-properties-common && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean



# Download and Install Vale

WORKDIR /tmp

RUN curl -O -L https://github.com/errata-ai/vale/releases/download/v${VALE_VERSION}/vale_${VALE_VERSION}_Linux_64-bit.tar.gz \
    && tar -zxf vale_${VALE_VERSION}_Linux_64-bit.tar.gz \
    && rm vale_${VALE_VERSION}_Linux_64-bit.tar.gz \
    && mv vale /usr/local/bin \
    && chmod a+x /usr/local/bin/vale


# Switch Workdir to /

WORKDIR /

# Entry Point
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
