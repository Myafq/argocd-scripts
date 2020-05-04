FROM alpine
ARG ARGOCD_VERSION=v1.5.3
ADD https://github.com/argoproj/argo-cd/releases/download/$ARGOCD_VERSION/argocd-linux-amd64 /bin/argocd
RUN mkdir scripts
COPY scripts /scripts
RUN chmod +x /scripts/* /bin/argocd
ENV PATH /scripts:$PATH