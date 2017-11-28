# DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS HEADER.
# 
# Copyright (c) 2017 Oracle and/or its affiliates. All rights reserved.
# 
# GlassFish on Docker with Oracle Linux and OpenJDK
FROM oraclelinux:7-slim

# Maintainer
MAINTAINER Mensah Alkebu-Lan<malkebu-lan@uequations.com>

# Set environment variables and default password for user 'admin'
ENV GLASSFISH_PKG=glassfish-5.0-web.zip \
    GLASSFISH_URL=http://download.oracle.com/glassfish/5.0/release/glassfish-5.0-web.zip \
    GLASSFISH_HOME=/glassfish5 \
    MD5=66deb8024be5ce45059cca86ff2b88bc \
    PATH=$PATH:/glassfish5/bin \
    JAVA_HOME=/usr/lib/jvm/java-openjdk \
    JSF=javax.faces-2.2.8-11.jar \
    UEL=javax.el-3.0.1-b08.jar

# Install packages, download and extract GlassFish
# Setup password file
# Enable DAS
RUN yum -y install unzip java-1.8.0-openjdk-devel && \
    curl -O $GLASSFISH_URL && \
    echo "$MD5 *$GLASSFISH_PKG" | md5sum -c - && \
    unzip -o $GLASSFISH_PKG && \
    rm -f $GLASSFISH_PKG

# Install Expression Language 3.0
#RUN curl -O http://central.maven.org/maven2/org/glassfish/javax.el/3.0.1-b08/$UEL
#RUN mv $UEL $GLASSFISH_HOME/glassfish/modules/javax.el.jar

# Install JSF
#RUN curl -O https://repo.maven.apache.org/maven2/org/glassfish/javax.faces/2.2.8-11/$JSF 
#RUN mv $JSF $GLASSFISH_HOME/glassfish/modules/javax.faces.jar

# Install adf-essentials.zip
ADD adf-essentials.zip /adf-essentials.zip

RUN unzip -jo /adf-essentials.zip -d $GLASSFISH_HOME/glassfish/domains/domain1/lib/applibs && \
    yum -y remove unzip && \
    rm -rf /var/cache/yum && \
    rm -f /adf-essentials.zip

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# Ports being exposed
EXPOSE 4848 8080 8181

# Start asadmin console and the domain
CMD ["asadmin", "start-domain", "-v"]
