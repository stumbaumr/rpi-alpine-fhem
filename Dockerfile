FROM armhf/alpine:latest

ENV FHEM_VERSION 5.7

RUN apk add --update perl \
                     perl-device-serialport \
                     perl-io-socket-ssl \
                     perl-libwww \
                     perl-xml-simple \
        && rm -rf /var/cache/apk/*

ADD http://fhem.de/fhem-${FHEM_VERSION}.tar.gz /tmp/fhem.tar

RUN mkdir /opt && cd /opt && \
    tar xf /tmp/fhem.tar && \
    ln -s /opt/fhem-${FHEM_VERSION} /opt/fhem && \
    addgroup fhem && \
    adduser -D -G fhem -h /opt/fhem -u 501 fhem && \
    rm /tmp/fhem.tar

EXPOSE 8083 8084 8085 7072

WORKDIR /opt/fhem

USER fhem

CMD /usr/bin/perl fhem.pl fhem.cfg

