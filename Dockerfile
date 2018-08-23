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
    ros install fukamachi/qlot && \
    ros install fukamachi/utopian && \
    mv ${HOME}/.roswell/bin/lem ${HOME}/.roswell/bin/lem2 && \
    mv ${HOME}/.roswell/bin/lem-ncurses ${HOME}/.roswell/bin/lem

# --- open a port for running web applications --- #
EXPOSE 8888
