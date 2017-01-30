#! /bin/bash


if [ "$1" = "" -o "$1" = "-?" -o "$2" = "" ]; then
  echo "USAGE: $0 cassandra_download_url distro [csd_version]"
  echo "download mirrors for current Apache Cassandra versions can be found at: http://cassandra.apache.org/download/"
  echo "for instance: $0 http://www-us.apache.org/dist/cassandra/3.9/apache-cassandra-3.9-bin.tar.gz"
  echo "valid options for the linux distribution are: el5|el6|el7|sles11|sles12|lucid|precise|trusty|squeeze|wheezy|jessie"
else
  . download_cassandra.sh $1
  . install_cm_ext.sh
  . build_parcel.sh $(cat .downloaded) $2
  CSD_VERSION=${3:-1.0}
  . build_csd.sh $CSD_VERSION
fi
