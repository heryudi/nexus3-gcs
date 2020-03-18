FROM sonatype/nexus3:3.20.1

WORKDIR /opt/sonatype/nexus/deploy/

COPY nexus-blobstore-google-cloud-0.10.2-bundle.kar .

LABEL maintainer="Heryudi Ganesha <heryudi@gmail.com>" \
      version="1.0"
