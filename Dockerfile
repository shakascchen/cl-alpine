FROM frolvlad/alpine-glibc:alpine-3.6

ARG work_dir=/tmp/setup
RUN mkdir ${work_dir} && \
    chmod 777 ${work_dir}

# --- install roswell and some common lisp implementations --- #

RUN apk add --no-cache git automake autoconf make gcc build-base curl-dev curl glib-dev openssl-dev ncurses-dev && \
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

ENV PATH /root/.roswell/bin:${PATH}

EXPOSE 4000

RUN ln -s ${HOME}/.roswell/local-projects work && \
    ros install fukamachi/clack && \
    ros install fukamachi/caveman && \
    ros install cxxxr/lem && \
    mv ${HOME}/.roswell/bin/lem ${HOME}/.roswell/bin/lem2 && \
    mv ${HOME}/.roswell/bin/lem-ncurses ${HOME}/.roswell/bin/lem && \
    curl -O https://raw.githubusercontent.com/t-cool/cl-base/master/app.lisp && \
    lem 
