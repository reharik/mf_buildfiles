
# EventStore (geteventstore.com)
# STOLEN FROM adbrowne/eventstore 
# VERSION               0.0.2

FROM      ubuntu

MAINTAINER Raif Harik <reharik@gmail.com>

RUN apt-get update && apt-get install -y curl

RUN curl http://download.geteventstore.com/binaries/EventStore-OSS-Linux-v3.0.5.tar.gz | tar xz -C /opt

EXPOSE 2113
EXPOSE 1113

ENV EVENTSTORE_MAX_MEM_TABLE_SIZE 100000
ENV EVENTSTORE_WORKER_THREADS 12

WORKDIR /opt/EventStore-OSS-Linux-v3.0.5

CMD ./run-node.sh --http-prefixes=http://*:2113/ --ext-ip=0.0.0.0 --stats-period-sec=300 --db /data/eventstore/db --log /data/eventstore/logs --run-projections=all


