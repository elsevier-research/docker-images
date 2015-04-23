#
# Elasticsearch image
#

FROM 1science/java:oracle-jre-7
MAINTAINER 1science Devops Team <devops@1science.org>

ENV ES_VERSION 1.5.1
ENV ES_HOME /usr/share/elasticsearch
ENV PATH $PATH:$ES_HOME/bin

# Install Elasticsearch and plugins
RUN curl -Ls https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-$ES_VERSION.tar.gz | gunzip | tar -x -C /usr/share && \
    ln -s /usr/share/elasticsearch-$ES_VERSION $ES_HOME && \
    plugin -install lmenezes/elasticsearch-kopf/v1.4.3 && \
    plugin -install royrusso/elasticsearch-HQ && \
    plugin -install elasticsearch/elasticsearch-cloud-aws/2.4.1 && \
    echo -ne "- with elasticsearch `elasticsearch -v`\n" >> /root/.built

COPY config /usr/share/elasticsearch/config

VOLUME /var/lib/elasticsearch

EXPOSE 9200 9300

CMD ["elasticsearch"]

