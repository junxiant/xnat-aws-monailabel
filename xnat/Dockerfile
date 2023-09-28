FROM tomcat:9.0.80-jdk8-corretto-al2
MAINTAINER Junxian <junxiantjx@gmail.com>

USER root

# Change later
RUN chmod -R 777 .

ARG XNAT_VERSION=1.8.9.1

ENV XNAT_ROOT=/data/xnat
ENV XNAT_HOME=/data/xnat/home
ENV XNAT_DATASOURCE_DRIVER=${XNAT_DATASOURCE_DRIVER:-org.postgresql.Driver}
ENV XNAT_DATASOURCE_URL=${XNAT_DATASOURCE_URL:-xnatdb}
ENV XNAT_DATASOURCE_USERNAME=${XNAT_DATASOURCE_USERNAME:-xnat}
ENV XNAT_DATASOURCE_PASSWORD=${XNAT_DATASOURCE_PASSWORD:-xnat}
ENV XNAT_EMAIL=${XNAT_EMAIL:-test@test.com}
ENV XNAT_PROCESSING_URL=http://localhost:8080
ENV XNAT_SMTP_ENABLED=${XNAT_SMTP_ENABLED:-false}
ENV XNAT_SMTP_HOSTNAME=${XNAT_SMTP_HOSTNAME:-fake.fake}
ENV XNAT_SMTP_PORT=${XNAT_SMTP_PORT:-9999}
ENV XNAT_SMTP_AUTH=${XNAT_SMTP_AUTH:-test}
ENV XNAT_SMTP_USERNAME=${XNAT_SMTP_USERNAME:-test}
ENV XNAT_SMTP_PASSWORD=${XNAT_SMTP_PASSWORD:-test}

ADD make-xnat-config.sh /usr/local/bin/make-xnat-config.sh
ADD wait-for-postgres.sh /usr/local/bin/wait-for-postgres.sh

RUN yum -y update
RUN yum update && yum install -y postgresql-client wget 
RUN yum install -y unzip
RUN yum install -y postgresql
RUN yum install -y vim

RUN rm -rf /usr/local/tomcat/webapps/*
RUN wget --no-verbose --output-document=/tmp/xnat-web-${XNAT_VERSION}.war https://api.bitbucket.org/2.0/repositories/xnatdev/xnat-web/downloads/xnat-web-${XNAT_VERSION}.war
RUN unzip -o -d /usr/local/tomcat/webapps/ROOT /tmp/xnat-web-${XNAT_VERSION}.war

RUN rm -f /tmp/xnat-web-${XNAT_VERSION}.war
RUN sed -i '/<Context>/a \     <Resources cacheMaxSize="51200" \/>' /usr/local/tomcat/conf/context.xml

# Fix ECR enhanced scan CVEs 

RUN wget https://repo1.maven.org/maven2/com/thoughtworks/xstream/xstream/1.4.20/xstream-1.4.20.jar -P /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/
RUN rm -rf /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/xstream-1.4.9.jar

RUN wget https://repo1.maven.org/maven2/org/apache/xmlbeans/xmlbeans/3.0.0/xmlbeans-3.0.0.jar -P /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/
RUN rm -rf /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/xmlbeans-2.6.0.jar

RUN wget https://repo1.maven.org/maven2/org/postgresql/postgresql/42.3.8/postgresql-42.3.8.jar -P /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/
RUN rm -rf /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/postgresql-42.2.10.jar

RUN wget https://repo1.maven.org/maven2/org/quartz-scheduler/quartz/2.3.2/quartz-2.3.2.jar -P /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/
RUN rm -rf /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/quartz-2.2.1.jar

RUN wget https://repo1.maven.org/maven2/io/springfox/springfox-swagger-ui/2.10.0/springfox-swagger-ui-2.10.0.jar -P /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/
RUN rm -rf /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/springfox-swagger-ui-2.9.2.jar

# "HIGH"
RUN wget https://repo1.maven.org/maven2/org/json/json/20230227/json-20230227.jar -P /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/
RUN rm -rf /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/json-20160810.jar

RUN wget https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-databind/2.13.4.2/jackson-databind-2.13.4.2.jar -P /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/
RUN rm -rf /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/jackson-databind-2.13.3.jar

RUN wget https://repo1.maven.org/maven2/org/apache/ant/ant/1.10.11/ant-1.10.11.jar -P /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/
RUN rm -rf /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/ant-1.9.8.jar

RUN wget https://repo1.maven.org/maven2/org/apache/commons/commons-compress/1.21/commons-compress-1.21.jar -P /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/
RUN rm -rf /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/commons-compress-1.20.jar

RUN wget https://repo1.maven.org/maven2/org/apache/commons/commons-email/1.5/commons-email-1.5.jar -P /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/
RUN rm -rf /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/commons-email-1.4.jar

RUN wget https://repo1.maven.org/maven2/com/fasterxml/woodstox/woodstox-core/6.4.0/woodstox-core-6.4.0.jar -P /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/
RUN rm -rf /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/woodstox-core-6.2.7.jar

RUN wget https://repo1.maven.org/maven2/net/minidev/json-smart/2.4.9/json-smart-2.4.9.jar -P /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/
RUN rm -rf /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/json-smart-2.3.jar

RUN wget https://repo1.maven.org/maven2/commons-beanutils/commons-beanutils/1.9.4/commons-beanutils-1.9.4.jar -P /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/
RUN rm -rf /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/commons-beanutils-1.9.3.jar

RUN wget https://repo1.maven.org/maven2/org/python/jython-standalone/2.7.3/jython-standalone-2.7.3.jar -P /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/
RUN rm -rf /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/jython-standalone-2.7.1.jar

RUN wget https://repo1.maven.org/maven2/com/github/jnr/jnr-posix/3.1.8/jnr-posix-3.1.8.jar -P /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/
RUN rm -rf /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/jnr-posix-3.0.50.jar

RUN wget https://repo1.maven.org/maven2/net/sourceforge/nekohtml/nekohtml/1.9.22/nekohtml-1.9.22.jar -P /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/
RUN rm -rf /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/nekohtml-1.9.16.jar

RUN wget https://repo1.maven.org/maven2/com/mchange/c3p0/0.9.5.5/c3p0-0.9.5.5.jar -P /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/
RUN rm -rf /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/c3p0-0.9.1.1.jar


# Everything else below commented out because later versions not supported/causes crashes
# Problem
# RUN wget https://repo1.maven.org/maven2/org/hibernate/hibernate-core/5.6.1.Final/hibernate-core-5.6.1.Final.jar -P /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/
# RUN rm -rf /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/hibernate-core-4.3.11.Final.jar

# RUN wget https://repo1.maven.org/maven2/com/google/guava/guava/32.1.1-jre/guava-32.1.1-jre.jar -P /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/
# RUN rm -rf /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/guava-20.0.jar

# Problem 1. This needs 2.0
RUN wget https://repo1.maven.org/maven2/org/yaml/snakeyaml/1.33/snakeyaml-1.33.jar -P /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/
RUN rm -rf /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/snakeyaml-1.30.jar


# Problem 2
# RUN wget https://repo1.maven.org/maven2/org/springframework/security/spring-security-web/6.0.0/spring-security-web-6.0.0.jar -P /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/
# RUN rm -rf /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/spring-security-web-4.2.20.RELEASE.jar

# RUN wget https://repo1.maven.org/maven2/org/springframework/security/spring-security-core/6.0.0/spring-security-core-6.0.0.jar -P /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/
# RUN rm -rf /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/spring-security-core-4.2.20.RELEASE.jar

# RUN wget https://repo1.maven.org/maven2/org/springframework/security/spring-security-acl/6.0.0/spring-security-acl-6.0.0.jar -P /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/
# RUN rm -rf /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/spring-security-acl-4.2.20.RELEASE.jar

# RUN wget https://repo1.maven.org/maven2/org/springframework/security/spring-security-aspects/6.0.0/spring-security-aspects-6.0.0.jar -P /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/
# RUN rm -rf /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/spring-security-aspects-4.2.20.RELEASE.jar

# RUN wget https://repo1.maven.org/maven2/org/springframework/security/spring-security-config/6.1.2/spring-security-config-6.1.2.jar -P /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/
# RUN rm -rf /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/-security-config-4.2.20.RELEASE.jar

# RUN wget https://repo1.maven.org/maven2/org/springframework/security/spring-security-taglibs/6.0.0/spring-security-taglibs-6.0.0.jar -P /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/
# RUN rm -rf /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/spring-security-taglibs-4.2.20.RELEASE.jar

# RUN wget https://repo1.maven.org/maven2/org/springframework/security/spring-security-ldap/6.0.0/spring-security-ldap-6.0.0.jar -P /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/
# RUN rm -rf /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/spring-security-ldap-4.2.20.RELEASE.jar

# # Problem 3
# RUN wget https://repo1.maven.org/maven2/org/springframework/spring-web/6.0.0/spring-web-6.0.0.jar -P /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/
# RUN rm -rf /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/spring-web-4.3.30.RELEASE.jar

# # Problem 4
# RUN wget https://repo1.maven.org/maven2/org/springframework/spring-beans/6.0.0/spring-beans-6.0.0.jar -P /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/
# RUN rm -rf /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/spring-beans-4.3.30.RELEASE.jar

# RUN wget https://repo1.maven.org/maven2/org/springframework/spring-webmvc/6.0.0/spring-webmvc-6.0.0.jar -P /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/
# RUN rm -rf /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/spring-webmvc-4.3.30.RELEASE.jar


# RUN wget https://repo1.maven.org/maven2/org/springframework/spring-tx/6.0.0/spring-tx-6.0.0.jar -P /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/
# RUN wget https://repo1.maven.org/maven2/org/springframework/spring-aop/6.0.0/spring-aop-6.0.0.jar -P /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/
# RUN wget https://repo1.maven.org/maven2/org/springframework/spring-context/6.0.0/spring-context-6.0.0.jar -P /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/
# RUN wget https://repo1.maven.org/maven2/org/springframework/spring-context-support/6.0.0/spring-context-support-6.0.0.jar -P /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/
# RUN wget https://repo1.maven.org/maven2/org/springframework/spring-core/6.0.0/spring-core-6.0.0.jar -P /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/
# RUN wget https://repo1.maven.org/maven2/org/springframework/spring-expression/6.0.0/spring-expression-6.0.0.jar -P /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/
# RUN wget https://repo1.maven.org/maven2/org/springframework/spring-jdbc/6.0.0/spring-jdbc-6.0.0.jar -P /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/
# RUN wget https://repo1.maven.org/maven2/org/springframework/spring-jms/6.0.0/spring-jms-6.0.0.jar -P /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/

# RUN rm -rf /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/spring-tx-4.3.30.RELEASE.jar
# RUN rm -rf /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/spring-aop-4.3.30.RELEASE.jar 
# RUN rm -rf /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/spring-context-4.3.30.RELEASE.jar 
# RUN rm -rf /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/spring-context-support-4.3.30.RELEASE.jar
# RUN rm -rf /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/spring-core-4.3.30.RELEASE.jar 
# RUN rm -rf /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/spring-expression-4.3.30.RELEASE.jar
# RUN rm -rf /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/spring-jdbc-4.3.30.RELEASE.jar
# RUN rm -rf /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/spring-jms-4.3.30.RELEASE.jar


EXPOSE 8080

CMD ["wait-for-postgres.sh", "/usr/local/tomcat/bin/catalina.sh", "run"]


# List of related packages which raises CVEs
# spring-aop-4.3.30.RELEASE.jar 
# spring-beans-4.3.30.RELEASE.jar #1
# spring-context-4.3.30.RELEASE.jar 
# spring-context-support-4.3.30.RELEASE.jar
# spring-core-4.3.30.RELEASE.jar 
# spring-expression-4.3.30.RELEASE.jar
# spring-jdbc-4.3.30.RELEASE.jar
# spring-jms-4.3.30.RELEASE.jar

# spring-ldap-core-2.3.3.RELEASE.jar

# spring-messaging-4.3.30.RELEASE.jar
# spring-orm-4.3.30.RELEASE.jar
# spring-oxm-4.3.30.RELEASE.jar

# spring-plugin-core-1.2.0.RELEASE.jar
# spring-plugin-metadata-1.2.0.RELEASE.jar


# spring-security-web-4.2.20.RELEASE.jar #1
# spring-security-core-4.2.20.RELEASE.jar #1 

# spring-security-acl-4.2.20.RELEASE.jar
# spring-security-aspects-4.2.20.RELEASE.jar
# spring-security-config-4.2.20.RELEASE.jar
# spring-security-taglibs-4.2.20.RELEASE.jar
# spring-security-ldap-4.2.20.RELEASE.jar

# spring-security-jwt-1.1.1.RELEASE.jar
# spring-security-oauth2-2.5.0.RELEASE.jar

# spring-tx-4.3.30.RELEASE.jar
# spring-web-4.3.30.RELEASE.jar #1
# spring-webmvc-4.3.30.RELEASE.jar #1