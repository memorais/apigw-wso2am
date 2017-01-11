FROM centos:centos6.6

MAINTAINER Infra Vertigo <infra@vertigo.com.br>

# Install wget and unzip

RUN  yum install -y wget && yum install -y tar  && yum install -y unzip

# Download do Oracle Java 7 e Descompactar
RUN  cd /opt/ && wget http://infra-vertigo.s3.amazonaws.com/sfw/jdk-7u71-linux-x64.tar.gz && tar -xf jdk-7u71-linux-x64.tar.gz && chown root:root -R jdk1.7.0_71/ && rm -f jdk-7u71-linux-x64.tar.gz && export JAVA_HOME=/opt/jdk1.7.0_71/

# Set JAVA_HOME
ENV JAVA_HOME /opt/jdk1.7.0_71/

# Download and extract wso2am-2.0.0
RUN wget http://infra-vertigo.s3.amazonaws.com/sfw/wso2am-2.0.0.zip -O /tmp/wso2am-2.0.0.zip && \
    unzip /tmp/wso2am-2.0.0.zip -d /opt && \
    rm -f /tmp/wso2am-2.0.0.zip

# Creates a default place to deploy carbonapps  
RUN ln -s /carbonapps /opt/wso2am-2.0.0/repository/deployment/server/carbonapps

# Exporting ports
EXPOSE 9443
EXPOSE 9763
EXPOSE 10389
EXPOSE 8000
EXPOSE 10397
EXPOSE 8243
EXPOSE 8280
EXPOSE 7711

#Running APIM
CMD ["/opt/wso2am-2.0.0/bin/wso2server.sh"]
