FROM ubuntu:xenial
MAINTAINER Thomas B. Mooney <tmooney@genome.wustl.edu>

LABEL \
  version="1.0.15" \
  description="Strelka image for use in Workflows"

RUN apt-get update
RUN apt-get install -y \
  bzip2 \
  g++ \
  make \
  perl-doc \
  python \
  rsync \
  wget \
  zlib1g-dev

ENV STRELKA_INSTALL_DIR /opt/strelka

WORKDIR /tmp
RUN wget ftp://strelka:%27%27@ftp.illumina.com/v1-branch/v1.0.15/strelka_workflow-1.0.15.tar.gz
RUN tar -xzf strelka_workflow-1.0.15.tar.gz

WORKDIR /tmp/strelka_workflow-1.0.15
RUN ./configure --prefix=$STRELKA_INSTALL_DIR
RUN make

WORKDIR /
RUN rm -rf /tmp/strelka*

#strelka requires a couple steps to run, so add a helper script to sequence those
ADD docker_helper.sh /usr/bin/
ENTRYPOINT ["/usr/bin/docker_helper.sh"]
