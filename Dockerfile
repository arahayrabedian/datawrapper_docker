FROM jbfink/lampstack:latest

MAINTAINER Ara Hayrabedian <ara.hayrabedian@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

ENV DATAWRAPPER_ROOT_DIRECTORY /usr/bin/datawrapper
ENV DATAWRAPPER_WWW_DIRECTORY $DATAWRAPPER_ROOT_DIRECTORY/www
ENV DATAWRAPPER_WWW_CHART_DIRECTORY $DATAWRAPPER_ROOT_DIRECTORY/charts/static

ADD templates/ /tmp/templates

RUN ls -alh /tmp/templates

RUN apt-get update -yq && apt-get install -y software-properties-common python-software-properties
RUN add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) main universe restricted multiverse"
 
RUN apt-get update -yq && \
    apt-get install -yqf zip curl git tree python-pip && \
    apt-get -y autoremove && \
    apt-get clean && \
    pip install envtpl

RUN mkdir -p $DATAWRAPPER_ROOT_DIRECTORY && \
    git clone https://github.com/datawrapper/datawrapper.git $DATAWRAPPER_ROOT_DIRECTORY

#remove default apache config to overwrite with our own as well as datawrapper config.
RUN rm /etc/apache2/sites-enabled/000-default && \
    envtpl < /tmp/templates/apache_config.template > /etc/apache2/sites-enabled/000-default && \
    envtpl < /tmp/templates/config.yaml.template > $DATAWRAPPER_ROOT_DIRECTORY/config.yaml

WORKDIR $DATAWRAPPER_ROOT_DIRECTORY
RUN curl -sS https://getcomposer.org/installer | php
RUN php composer.phar install