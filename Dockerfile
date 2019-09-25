FROM alpine:3.10

LABEL MAINTAINER="Xijun Dai <daixijun1990@gmail.com>"

ENV KUBECTL_VERSION=1.6.0
ENV KUSTOMIZE_VERSION=3.2.0
ENV KUBEDOG_VERSION=0.3.4
ENV TKN_VERSION=0.3.1
ENV HELM_V2_VERSION=2.14.3
ENV HELM_V3_VERSION=3.0.0-beta.3
ENV YQ_VERSION=2.4.0

RUN apk update \
    && apk add --no-cache ca-certificates curl \
    # Kubectl
    && curl --silent -L https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    # kustomize
    && curl --silent -L https://github.com/kubernetes-sigs/kustomize/releases/download/v${KUSTOMIZE_VERSION}/kustomize_${KUSTOMIZE_VERSION}_linux_amd64 -o /usr/local/bin/kustomize \
    && chmod +x /usr/local/bin/kustomize \
    # kubedog
    && curl --silent -L https://dl.bintray.com/flant/kubedog/v${KUBEDOG_VERSION}/kubedog-linux-amd64-v${KUBEDOG_VERSION} -o /usr/local/bin/kubedog \
    && chmod +x /usr/local/bin/kubedog \
    # Tekton cli
    && curl --silent -L https://github.com/tektoncd/cli/releases/download/v${TKN_VERSION}/tkn_${TKN_VERSION}_Linux_x86_64.tar.gz -o /tmp/tkn.tar.gz \
    && tar xf /tmp/tkn.tar.gz \
    && rm -f /tmp/tkn.tar.gz \
    && mv tkn /usr/local/bin/tkn \
    && chmod +x /usr/local/bin/tkn \
    # helm v3
    && curl --silent -L https://get.helm.sh/helm-v${HELM_V3_VERSION}-linux-amd64.tar.gz -o /tmp/helmv3.tar.gz \
    && tar xf /tmp/helmv3.tar.gz -C /tmp/ \
    && mv /tmp/linux-amd64/helm /usr/local/bin/helmv3 \
    && chmod +x /usr/local/bin/helmv3 \
    && rm -rf /tmp/linux-amd64 /tmp/helmv3.tar.gz \
    # helm v2
    && curl --silent -L https://get.helm.sh/helm-v${HELM_V2_VERSION}-linux-amd64.tar.gz -o /tmp/helmv2.tar.gz \
    && tar xf /tmp/helmv2.tar.gz -C /tmp/ \
    && mv /tmp/linux-amd64/helm /usr/local/bin/helm \
    && chmod +x /usr/local/bin/helm \
    && rm -rf /tmp/linux-amd64 /tmp/helmv2.tar.gz \
    # yq
    && curl --silent -L https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_amd64 -o /usr/local/bin/yq \
    && chmod +x /usr/local/bin/yq \
    && rm -fr /var/cache/apk/* /root/.cache

ENTRYPOINT [ "/usr/local/bin/kubectl" ]
CMD [ "--help" ]