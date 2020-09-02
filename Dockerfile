FROM openjdk:8

ENV HIVE_VERSION=3.1.2
ENV HADOOP_VERSION=3.3.0

ENV APPS_ROOT=/usr/local
ENV HIVE_HOME=${APPS_ROOT}/apache-hive-${HIVE_VERSION}-bin
ENV HADOOP_HOME=${APPS_ROOT}/hadoop-${HADOOP_VERSION}

RUN apt-get update && apt-get install -y \
    ssh \
    pdsh && \
    wget http://apache.mirrors.spacedump.net/hadoop/common/hadoop-3.3.0/hadoop-${HADOOP_VERSION}.tar.gz && \
    tar -xzvf hadoop-${HADOOP_VERSION}.tar.gz -C $APPS_ROOT/ && \
    rm hadoop-${HADOOP_VERSION}.tar.gz && \
    wget http://apache.mirrors.spacedump.net/hive/hive-3.1.2/apache-hive-${HIVE_VERSION}-bin.tar.gz && \
    tar -xzvf apache-hive-${HIVE_VERSION}-bin.tar.gz -C $APPS_ROOT/ && \
    rm apache-hive-${HIVE_VERSION}-bin.tar.gz

ENV PATH=$HIVE_HOME/bin:$PATH
ENV PATH=$HADOOP_HOME/bin:$PATH

RUN hadoop fs -mkdir -p /tmp
RUN hadoop fs -mkdir -p /user/hive/warehouse
RUN hadoop fs -chmod g+w   /tmp
RUN hadoop fs -chmod g+w   /user/hive/warehouse

RUN rm $HIVE_HOME/lib/guava-*.jar
RUN cp $HADOOP_HOME/share/hadoop/hdfs/lib/guava-*.jar $HIVE_HOME/lib/

RUN schematool -dbType derby -initSchema
