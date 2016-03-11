FROM phusion/baseimage:0.9.18
MAINTAINER Dave Oxley <webhook-docker@oxley.email>

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -yq install \
    git

ENV GOPATH /go
ENV SRCPATH ${GOPATH}/src/github.com/adnanh
ENV WEBHOOK_VERSION 2.3.7
ENV PATH=$PATH:/usr/local/go/bin

RUN curl -O https://storage.googleapis.com/golang/go1.5.3.linux-amd64.tar.gz && \
    tar -xvf go1.5.3.linux-amd64.tar.gz && \
    mv go /usr/local && \
    echo "PATH=$PATH:/usr/local/go/bin" >> /etc/environment && \
    rm -f go1.5.3.linux-amd64.tar.gz

RUN curl -L -o /tmp/webhook-${WEBHOOK_VERSION}.tar.gz https://github.com/adnanh/webhook/archive/${WEBHOOK_VERSION}.tar.gz && \
    mkdir -p ${SRCPATH} && tar -xvzf /tmp/webhook-${WEBHOOK_VERSION}.tar.gz -C ${SRCPATH} && \
    mv -f ${SRCPATH}/webhook-* ${SRCPATH}/webhook && \
    cd ${SRCPATH}/webhook && go get -d && go build -o /usr/local/bin/webhook && \
    rm -rf ${GOPATH}

RUN mkdir /etc/service/webhook
COPY webhook.sh /etc/service/webhook/run

EXPOSE 9000

CMD ["/sbin/my_init"]

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
