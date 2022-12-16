FROM maven:3.6.3-jdk-11-slim AS build
RUN mkdir /usr/local/tomcat/
WORKDIR /usr/local/tomcat/
COPY . /usr/src/app/
WORKDIR /usr/src/app/
RUN mvn -f /usr/src/app/pom.xml clean package
FROM tomcat:8.5-jdk8 
COPY DMClient.properties /usr/local/tomcat/bin
WORKDIR /usr/src/app
ADD /*.war /DMClient.war
COPY --from=build /usr/src/app/target/*.war /usr/local/tomcat/webapps
EXPOSE 8080
CMD ["catalina.sh", "run"]




