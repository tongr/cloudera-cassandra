#! /bin/bash

if [[ -z "$1" ]]; then
  echo "USAGE: $0 cassandra_download_url"
  echo "download mirrors for current Apache Cassandra versions can be found at: http://cassandra.apache.org/download/"
  echo "for instance: $0 http://www-us.apache.org/dist/cassandra/3.9/apache-cassandra-3.9-bin.tar.gz"
else
  rm -f tmp
  wget $1 -O tmp
  tar xfzv tmp | cut -d/ -f1 | grep -v '^$' | sort -u > .downloaded
  rm -f tmp
  VERSION="$(cat .downloaded | sed -e 's/apache-cassandra-//g')"
  rm -rf "CASSANDRA-$VERSION"
  mv "$(cat .downloaded)" "CASSANDRA-$VERSION"
  echo "CASSANDRA-$VERSION" > .downloaded
fi

