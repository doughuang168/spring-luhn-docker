FROM java:8
RUN apt-get update && apt-get -y --no-install-recommends install \
    ca-certificates \
    curl
RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4
RUN curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.4/gosu-$(dpkg --print-architecture)" \
    && curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.4/gosu-$(dpkg --print-architecture).asc" \
    && gpg --verify /usr/local/bin/gosu.asc \
    && rm /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu

EXPOSE 8080

RUN mkdir /home/luhn
COPY ./build/libs/spring-luhn-docker-1.0-SNAPSHOT.jar /home/luhn/luhnapi.jar
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN  chmod +x /usr/local/bin/entrypoint.sh
CMD  entrypoint.sh /usr/bin/java -Dluhn.api.key=$luhn_api_key -jar /home/luhn/luhnapi.jar
