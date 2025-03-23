FROM alpine:3.9 AS build-stage

ENV DIR_PREFIX /usr/local
ENV SRC_DIR $DIR_PREFIX/src
ENV BIN_DIR $DIR_PREFIX/bin

RUN apk --no-cache add git bash make automake autoconf pkgconfig gcc musl-dev libcaca-dev slang-dev \
    && git clone --depth 1 https://github.com/cacalabs/toilet $SRC_DIR/toilet \
    && cd $SRC_DIR/toilet \
    && ./bootstrap \
    && ./configure \
    && make \
    && install -m 0755 ./src/toilet $BIN_DIR \
    && mkdir /usr/local/share/figlet/ \
    && install -m 0644 ./fonts/*.tlf /usr/local/share/figlet/
RUN wget https://www.jedsoft.org/releases/jed/jed-0.99-19.tar.gz \
    && tar xvfz jed-0.99-19.tar.gz \
    && cd jed-0.99-19 \
    && ./configure \
    && make \
    && make install
    

FROM docker

# Packages required by game
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories 
RUN apk update && apk add --no-cache supervisor bash libcaca-dev sudo ncurses curl vim openssh sqlite
#slang-dev should be added if jed needs it

# Configure supervisor for running sshd and process_users as services
COPY configurations/supervisord.conf /etc/supervisord.conf
RUN adduser hobbiton -D -h /home/hobbiton -s /bin/bash

# toilet is a required package for some of the console 'graphics' outputs
COPY --from=build-stage /usr/local/bin/* /usr/local/bin/
COPY --from=build-stage /usr/local/src/toilet/fonts/* /usr/local/share/figlet/
COPY fonts/small.flf /usr/local/share/figlet

# load_bash.sh, allows the execution of .bashrc if it exists
COPY scripts/load_bash.sh /etc/profile.d/

# Startup script for dind
COPY scripts/startup.sh /usr/local/bin/startup.sh
RUN chmod +x /usr/local/bin/startup.sh

# Scripts for game
COPY middle_earth/ /usr/local/bin/middle_earth
ENV PATH="/usr/local/bin/middle_earth:$PATH"

#Archivo necesario para la creación de la base de datos
COPY db/middle_earth.sql /root
COPY scripts/config.sh /root
RUN chmod 755 /root/config.sh

COPY bashrc/hobbiton /home/hobbiton/.bashrc
RUN chown hobbiton:hobbiton /home/hobbiton/.bashrc

COPY bashrc/common /etc/skel/.bashrc
RUN echo "PermitEmptyPasswords yes" >> /etc/ssh/sshd_config
RUN ssh-keygen -A

RUN mkdir /usr/local/jed
COPY --from=build-stage /usr/local/jed /usr/local/jed

COPY pony/ /pony
COPY bashrc/root /root/.bashrc

CMD ["/usr/local/bin/startup.sh"]
