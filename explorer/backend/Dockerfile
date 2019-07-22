FROM rust:latest

RUN apt-get update \
    && apt-get install -yq \
        clang \
        cmake

RUN git clone https://github.com/kallewoof/electrs.git --branch 2019-07-signet /workspace/electrs

WORKDIR /workspace/electrs

RUN cargo build --release

RUN cp target/release/electrs /usr/bin

# Electrum RPC
EXPOSE 50001

# Prometheus monitoring
EXPOSE 4224

STOPSIGNAL SIGINT

CMD ["electrs", "-vvvv", "--timestamp", "--network", "signet"]
