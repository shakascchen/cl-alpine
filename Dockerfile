FROM frolvlad/alpine-glibc:alpine-3.6

ARG work_dir=/tmp/setup
RUN mkdir ${work_dir} && \
    chmod 777 ${work_dir}

# --- install roswell and some common lisp implementations --- #
RUN apk add --no-cache git automake autoconf make gcc build-base curl-dev curl glib-dev openssl-dev ncurses-dev libev-dev && \
    cd ${work_dir} && \
    git clone --depth=1 -b release https://github.com/roswell/roswell.git && \
    cd roswell && \
    sh bootstrap && \
    ./configure --disable-manual-install && \
    make && \
    make install && \
    cd .. && \
    rm -rf roswell && \
    ros run -q

# --- add PATH to roswell/bin --- #
ENV PATH /root/.roswell/bin:${PATH}

# --- install caveman, lem, darkmatter using roswell --- #
RUN ln -s ${HOME}/.roswell/local-projects work && \
    ros install fukamachi/caveman && \
    ros install cxxxr/lem && \
    ros install tamamu/darkmatter && \    
    mv ${HOME}/.roswell/bin/lem ${HOME}/.roswell/bin/lem2 && \
    mv ${HOME}/.roswell/bin/lem-ncurses ${HOME}/.roswell/bin/lem

# --- open a port for running web applications --- #
EXPOSE 8888

# --- PostgreSQL --- #
ENV PG_MAJOR 9.6
ENV PG_VERSION 9.6.8

ENV PATH /usr/lib/postgresql/$PG_MAJOR/bin:$PATH
ENV PGDATA /var/lib/postgresql/data

# ENV LANG en_US.utf8
ENV LANG ja_JP.utf8

RUN apk add build-base readline-dev openssl-dev zlib-dev libxml2-dev glib-lang wget gnupg ca-certificates libssl1.0 && \
    gpg --keyserver ipv4.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 && \
    gpg --list-keys --fingerprint --with-colons | sed -E -n -e 's/^fpr:::::::::([0-9A-F]+):$/\1:6:/p' | gpg --import-ownertrust && \
    wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/1.7/gosu-amd64" && \
    wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/1.7/gosu-amd64.asc" && \
    gpg --verify /usr/local/bin/gosu.asc && \
    rm /usr/local/bin/gosu.asc && \
    chmod +x /usr/local/bin/gosu && \
    mkdir -p /docker-entrypoint-initdb.d && \
    wget https://ftp.postgresql.org/pub/source/v$PG_VERSION/postgresql-$PG_VERSION.tar.bz2 -O /tmp/postgresql-$PG_VERSION.tar.bz2 && \
    tar xvfj /tmp/postgresql-$PG_VERSION.tar.bz2 -C /tmp && \
    cd /tmp/postgresql-$PG_VERSION && ./configure --enable-integer-datetimes --enable-thread-safety --prefix=/usr/local --with-libedit-preferred --with-openssl  && make world && make install world && make -C contrib install && \
    cd /tmp/postgresql-$PG_VERSION/contrib && make && make install && \
    apk --purge del build-base openssl-dev zlib-dev libxml2-dev wget gnupg ca-certificates && \
    rm -r /tmp/postgresql-$PG_VERSION* /var/cache/apk/*

VOLUME /var/lib/postgresql/data

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 5432
CMD ["postgres"]
