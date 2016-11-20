FROM java:8

EXPOSE 8080

RUN  mkdir /opt/mysay.api
RUN  mkdir /opt/mysay.api/build
RUN  mkdir /opt/mysay.api/gradle
RUN  mkdir /opt/mysay.api/grails-app
RUN  mkdir /opt/mysay.api/src

COPY build             /opt/mysay.api/build
COPY gradle            /opt/mysay.api/gradle
COPY src               /opt/mysay.api/src
COPY build.gradle      /opt/mysay.api/
COPY settings.gradle   /opt/mysay.api/
COPY gradlew           /opt/mysay.api/

RUN  mkdir /home/mysay.api
RUN  echo "#!/bin/bash                                          " >/home/mysay.api/start-service.sh
RUN  echo "cd /opt/mysay.api        "                           >>/home/mysay.api/start-service.sh
RUN  echo "./gradlew clean build"                               >>/home/mysay.api/start-service.sh
RUN  chmod +x /home/mysay.api/start-service.sh
RUN  /home/mysay.api/start-service.sh


ENV accessKey "YourAWSAccessKey"
ENV secretKey "YourAWSSecretKey"
ENV bucket    "YourAWSS3Bucket"
ENV region    "YourAWSRegion"
ENV endpoint  "https://sqs.us-west-2.amazonaws.com/450592484649"
ENV queueName "jenkins"

###
RUN  echo "#!/bin/bash                                         " >/home/mysay.api/start-app.sh
RUN  echo "cd /opt/mysay.api        "                           >>/home/mysay.api/start-app.sh
RUN  echo "./gradlew build" >> /home/mysay.api/start-app.sh
RUN  echo "java -Dcloud.aws.credentials.accessKey=$accessKey -Dcloud.aws.credentials.secretKey=$secretKey -Dqueue.endpoint=$endpoint -Dqueue.name=$queueName -Dcloud.aws.region=$region -Dcloud.aws.s3.bucket=$bucket -Dserver.port=8081 -jar build/libs/mysay-spring-cloud-aws-s3-1.0-SNAPSHOT.jar" >> /home/mysay.api/start-app.sh

RUN  chmod +x /home/mysay.api/start-app.sh
CMD  /home/mysay.api/start-app.sh
