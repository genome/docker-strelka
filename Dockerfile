FROM ubuntu:xenial
MAINTAINER Thomas B. Mooney <tmooney@genome.wustl.edu>

LABEL \
  version="2.9.9" \
  description="Strelka image for use in Workflows"

RUN apt-get update && apt-get install -y \
  bzip2 \
  g++ \
  make \
  perl-doc \
  python \
  rsync \
  wget \
  zlib1g-dev

ENV STRELKA_INSTALL_DIR /opt/strelka/

RUN wget https://github.com/Illumina/strelka/releases/download/v2.9.9/strelka-2.9.9.centos6_x86_64.tar.bz2 \
  && tar xf strelka-2.9.9.centos6_x86_64.tar.bz2 \
  && rm -f strelka-2.9.9.centos6_x86_64.tar.bz2 \
  && mv strelka-2.9.9.centos6_x86_64 $STRELKA_INSTALL_DIR

#strelka requires a couple steps to run, so add a helper script to sequence those
COPY docker_helper.pl /usr/bin/
ENTRYPOINT ["/usr/bin/docker_helper.pl"]
