# spring-luhn-docker
Spring Boot Luhn Algorithm Application Deploy as Docker Container 
## Welcome to Luhn RESTful API ##

**Luhn API** is a simple RESTful Web Service implemented in Java as Docker Container.  And hosted in Public cloud. 

### REST API ###


## Validate given card number is Luhn number 
Request url:

- curl --header "X-API-KEY: secretkey168" http://apihost:8080/api/validate/79927398713
 

Response JSON:

{
  "id": 3,
  "status": "OK",
  "message": "79927398713 is valid Luhn number",
  "result": "true"
}


## Generates the appropriate Luhn check digit for the card number 
Request url:

- curl --header "X-API-KEY: secretkey168" http://apihost:8080/api/checkdigit/79927398714
 

Response JSON:

{
  "id": 4,
  "status": "OK",
  "message": "Check digit is 6",
  "result": "6"
}

## Generates the appropriate Luhn check digit for the card number 
Request url:

- curl --header "X-API-KEY: secretkey168" http://apihost:8080/api/validcardnumber?startRange=7992739871&endRange=301

 

{
  "id": 5,
  "status": "OK",
  "message": "Number Of Valid LuhnNumbers In Range is 1",
  "result": "1"
}
 
## Angular  Demo
To see the dynamic nature of WebService being used. I implement a simple AngularJS controller as the WebService consumer.


You can see the demo at  [AWS](http://ec2-54-213-146-147.us-west-2.compute.amazonaws.com:8000/). It's end-point have been mapped to port 8000.



## Security
API Key is required to access Luhn API Service. The default key value is "secretkey168". The key value can be changed by using java command line argument,  -Dluhn.api.key=newKeyValue, or docker run command line switch "-e luhn_api_key=newKeyValue"

## Local Build
Download complete source thru Github:

- git clone https://github.com/doughuang168/spring-luhn-docker.git
 
- cd spring-luhn-docker


- In command windows type "./gradlew build" in Linux environment or ".\gradlew.bat build" in windows environment


- "java -Dluhn.api.key=secretkey168 -jar build\libs\spring-luhn-docker-1.0-SNAPSHOT.jar" to start the Luhn API Service

- in browser address bar type in url: http://localhost:8080

- Java 8 and gradle are required for build and run



## Using Docker to build and deploy

-  docker build -t luhn-api  .

-  docker run -d --name luhn-api -e luhn_api_key=secretkey168 -p 8080:8080 -e LOCAL_USER_ID=\`id -u $USER\` -t luhn-api

-  gosu will make the docker container not run as root to ease security concern

- Make sure configure your running host allow inbound traffic for port 8080   

