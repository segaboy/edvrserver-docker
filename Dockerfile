#base image. Official supported 64-bit LTS from Canonical
FROM ubuntu:14.04

# Allow for unassisted package installs
ENV DEBIAN_FRONTEND noninteractive

# Actually use Bash!
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Update packages silently, answering yes to all prompts
RUN apt-get update -yq

# Make sure base system is up-to-date
RUN apt-get upgrade -yq

# Install server dependencies
RUN apt-get install -yq \
  bind9-host \
  genisoimage \
  geoip-database \
  ifenslave \
  ifenslave-2.6 \
  krb5-config \
  krb5-locales \
  krb5-user \
  libbind9-90 \
  libdaemon0 \
  libdns100 \
  libedit2 \
  libgeoip1 \
  libgssapi-krb5-2 \
  libgssrpc4 \
  libio-socket-inet6-perl \
  libio-socket-ssl-perl \
  libisccc90 \
  libisccfg90 \
  libk5crypto3 \
  libkadm5clnt-mit9 \
  libkadm5srv-mit9 \
  libkdb5-7 \
  libkeyutils1 \
  libkrb5-3 \
  libkrb5support0 \
  liblwres90 \
  libnet-libidn-perl \
  libnet-ssleay-perl \
  libnspr4 \
  libnss3 \
  libnss3-nssdb \
  libnss3-tools \
  libopts25 \
  libpython-stdlib \
  libpython2.7-minimal \
  libpython2.7-stdlib \
  libsocket6-perl \
  libtcmalloc-minimal4 \
  libxml2 \
  ntp \
  python \
  python-minimal \
  python2.7 \
  python2.7-minimal \
  sgml-base \
  wget \
  xml-core \
  wodim

VOLUME		/lib/modules		 

# If deploying many Dockers, download the .deb packages to the host use COPY 
# to move them from the host to the container.

#Get exacqvisiondeps package from AWS bucket, and exacq server
RUN wget https://crm.exacq.com/release/Vision%20Server/7.9.x/exacqVisionServerDev-deps-7_9_7708_99724.deb
RUN wget https://crm.exacq.com/release/Vision%20Server/7.9.x/exacqVisionServerDev-7_9_7708_99724_amd64.deb
# RUN wget https://s3-us-west-2.amazonaws.com/exacqdocker/exacqVisionServer-deps.deb
# RUN wget https://s3-us-west-2.amazonaws.com/exacqdocker/exacqVisionServerDev-7_9_7708_99724_amd64.deb

RUN dpkg -i exacqVisionServerDev-deps-7_9_7708_99724.deb
RUN dpkg -i exacqVisionServerDev-7_9_7708_99724_amd64.deb

# Expose the listen port for the server service
EXPOSE 22609

ENTRYPOINT "/usr/exacq/server/core"
