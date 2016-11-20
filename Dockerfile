FROM phusion/baseimage

EXPOSE 8080

RUN apt-get update
RUN add-apt-repository ppa:webupd8team/java
RUN sudo add-apt-repository ppa:cwchien/gradle

RUN apt-get update
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
RUN apt-get -y install oracle-java8-installer supervisor gradle-2.9 git
RUN apt-get update

RUN java -version

#Fetch workeek micro-service source code from GitHub
RUN  mkdir /home/workweek-user
RUN  echo "#!/bin/bash                  " > /home/workweek-user/start-service.sh
RUN  echo "cd /opt                      " >>/home/workweek-user/start-service.sh
RUN  echo "git clone https://github.com/doughuang168/docker-spring-boot-scala-workweek" >>/home/workweek-user/start-service.sh
RUN  echo "cd /opt/docker-spring-boot-scala-workweek        "                           >>/home/workweek-user/start-service.sh
RUN  echo "chmod +x gradlew                                 "                           >>/home/workweek-user/start-service.sh
RUN  echo "./gradlew build"                                                             >>/home/workweek-user/start-service.sh
RUN  echo "cd /opt/docker-spring-boot-scala-workweek/build/libs"                        >>/home/workweek-user/start-service.sh
RUN  echo "java -jar spring-boot-scala-microservice-0.1.0.jar   "                       >>/home/workweek-user/start-service.sh
RUN  chmod +x /home/workweek-user/start-service.sh
CMD  /home/workweek-user/start-service.sh
