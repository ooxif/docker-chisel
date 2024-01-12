FROM debian:12-slim AS builder

RUN set -eux; \
	apt-get update -qq; \
	apt-get install -y curl git; \
	curl -L https://foundry.paradigm.xyz | bash; \
	~/.foundry/bin/foundryup

FROM gcr.io/distroless/cc-debian12:nonroot

COPY --from=builder /root/.foundry/bin/chisel /

ENTRYPOINT ["/chisel"]
