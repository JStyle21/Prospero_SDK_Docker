FROM debian:bookworm-slim

# Install basic dependencies and add LLVM repository
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    software-properties-common \
    && wget -qO- https://apt.llvm.org/llvm-snapshot.gpg.key | tee /etc/apt/trusted.gpg.d/apt.llvm.org.asc \
    && echo "deb http://apt.llvm.org/bookworm/ llvm-toolchain-bookworm-18 main" > /etc/apt/sources.list.d/llvm.list \
    && apt-get update && apt-get install -y \
    bash \
    clang-18 \
    lld-18 \
    make \
    git \
    curl \
    socat \
    cmake \
    meson \
    pkg-config \
    python3 \
    && rm -rf /var/lib/apt/lists/*

# Create SDK directories
RUN mkdir -p /opt/ps4-payload-sdk /opt/ps5-payload-sdk /src /project

# Clone and build PS4 SDK
WORKDIR /src
RUN git clone --depth 1 https://github.com/ps4-payload-dev/sdk.git ps4-sdk && \
    cd ps4-sdk && \
    make DESTDIR=/opt/ps4-payload-sdk install

# Clone and build PS5 SDK
RUN git clone --depth 1 https://github.com/ps5-payload-dev/sdk.git ps5-sdk && \
    cd ps5-sdk && \
    make DESTDIR=/opt/ps5-payload-sdk install

# Set up environment variables
ENV PS4_PAYLOAD_SDK=/opt/ps4-payload-sdk
ENV PS5_PAYLOAD_SDK=/opt/ps5-payload-sdk

# Default to PS5 SDK
ENV SDK_TYPE=ps5

# Set working directory for projects
WORKDIR /project

# Copy entrypoint script
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["make"]
