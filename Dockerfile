ARG GOLANG_VERSION=1.13.3

FROM golang:${GOLANG_VERSION} AS build

ENV PROTOC_VERSION=3.10.1

RUN curl -L -o /protoc-${PROTOC_VERSION}-linux-x86_64.zip https://github.com/google/protobuf/releases/download/v${PROTOC_VERSION}/protoc-${PROTOC_VERSION}-linux-x86_64.zip && \
  apt-get -q -y update && \
  apt-get -q -y install unzip && \
  mkdir -p /protoc && \
  unzip /protoc-${PROTOC_VERSION}-linux-x86_64.zip -d /protoc && \
  rm /protoc-${PROTOC_VERSION}-linux-x86_64.zip && \
  apt-get remove --purge -y unzip && \
  apt-get autoremove && \
  rm -rf /var/lib/apt/lists/* && \
  mkdir /protoc-gen-doc

WORKDIR /protoc-gen-doc

ADD . .

RUN go test ./... && \
  CGO_ENABLED=0 GOOS=linux make build

FROM debian:buster-slim

MAINTAINER NV <neovortex@gmail.com>

WORKDIR /

COPY --from=build /protoc-gen-doc/protoc-gen-doc /protoc/bin/protoc /usr/local/bin/
COPY --from=build /protoc/include/ /usr/local/include/
ADD script/entrypoint.sh ./

VOLUME ["/out", "/protos"]

ENTRYPOINT ["/entrypoint.sh"]
CMD ["--doc_opt=html,index.html"]
