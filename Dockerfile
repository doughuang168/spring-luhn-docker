FROM java:8

EXPOSE 8080

RUN mkdir /home/luhn

COPY ./build/libs/spring-luhn-docker-1.0-SNAPSHOT.jar /home/luhn/luhnapi.jar

RUN  echo "#!/bin/bash                                                  " >/home/luhn/start-service.sh
RUN  echo "cd /home/luhn                                                ">>/home/luhn/start-service.sh
RUN  echo "/usr/bin/java -Dluhn.api.key=\`echo \$luhn_api_key\` -jar luhnapi.jar" >>/home/luhn/start-service.sh

RUN  chmod +x /home/luhn/start-service.sh

CMD  /home/luhn/start-service.sh
