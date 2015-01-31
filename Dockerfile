FROM ubuntu:14.04

RUN apt-get update && apt-get install --no-install-recommends -y mysql-client python-pip && \
  pip install awscli && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

ENV MYSQLDUMP_OPTIONS --quote-names --quick --add-drop-table --add-locks --allow-keywords --disable-keys --extended-insert --single-transaction --create-options --comments --net_buffer_length=16384
ENV MYSQLDUMP_DATABASE --all-databases

ENV AWS_ACCESS_KEY_ID **None**
ENV AWS_SECRET_ACCESS_KEY **None**
ENV AWS_BUCKET **None**

ENV PREFIX **None**

ADD run.sh /run.sh
RUN chmod +x /run.sh

CMD ["/run.sh"]
