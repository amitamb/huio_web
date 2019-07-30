docker run -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" -e xpack.security.enabled=false -v `pwd`/tmp/esdata:/usr/share/elasticsearch/data docker.elastic.co/elasticsearch/elasticsearch:5.6.13

# 6.8.1