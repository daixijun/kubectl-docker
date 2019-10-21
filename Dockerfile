FROM alpine:3.10

LABEL MAINTAINER="Xijun Dai <daixijun1990@gmail.com>"

ENV KUBECTL_VERSION=1.16.0

RUN apk update \
    && apk add --no-cache ca-certificates curl \
    # Kubectl
    && curl --silent -L https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && rm -fr /var/cache/apk/* /root/.cache

ENTRYPOINT [ "/usr/local/bin/kubectl" ]
CMD [ "--help" ]
