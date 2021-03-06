FROM jxtadoop/java

MAINTAINER François Samin <francois.samin@gmail.com>

ENV DEBIAN_FRONTEND noninteractive 
ENV DEBCONF_NONINTERACTIVE_SEEN true

# Install MySQL
RUN apt-get install -y mysql-server mysql-client libmysqlclient-dev
RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf
ADD ./create_db.sh /create_db.sh
ADD ./startup-db.sh /startup-db.sh

# Install Git to retreive soapower source
RUN apt-get install -y git

# Install ssh for admin
RUN apt-get install -y ssh wget

# Install zip
RUN apt-get install -y zip

# Clean Aptitude
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Directory for ssh
RUN mkdir /var/run/sshd

# Create Soapower directory
RUN mkdir -p /opt/soapower

# Download Soapower distrib 1.1.1
RUN (cd /opt/soapower && wget --no-check-certificate https://github.com/soapower/soapower/releases/download/1.1.1/soapower-1.1.1.zip -O soapower-1.1.1.zip)

# Unzipping distrib 1.1.1
RUN (cd /opt/soapower && unzip soapower-1.1.1.zip)

# Create symbolic lynk
RUN (cd /opt/soapower && rm -f current; ln -s soapower-1.1.1 current)

# Download start-file
RUN (cd /opt/soapower/current && wget --no-check-certificate http://raw.github.com/soapower/soapower/1.1.1/soapowerctl.sh)

# Download logger-file
RUN (cd /opt/soapower/current && wget --no-check-certificate http://raw.github.com/soapower/soapower/1.1.1/conf/logger-prod.xml)

# Grants execution
RUN chmod +x /opt/soapower/current/soapowerctl.sh
RUN chmod +x /opt/soapower/current/start

ADD run.sh /run.sh

CMD ["/run.sh"]

EXPOSE 3306 9010 22
