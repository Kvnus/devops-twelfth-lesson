# ---- build stage: проект собран под Java 6, поэтому берём JDK 8 (последний, умеющий target 1.6)
FROM maven:3.8.8-eclipse-temurin-8 AS build
WORKDIR /build
COPY pom.xml .
RUN mvn -q -B dependency:go-offline || true
COPY src ./src
COPY WebContent ./WebContent
# старые jar'ы в WEB-INF/lib (mysql-connector 3.1.8, spring 2.5.6) дублируют зависимости из pom.xml
# и конфликтуют с ними (два com.mysql.jdbc.Driver) — берём версии из maven
RUN rm -rf WebContent/WEB-INF/lib \
 && mvn -q -B package -DskipTests

# ---- runtime stage
FROM tomcat:9.0-jdk8-temurin
RUN rm -rf /usr/local/tomcat/webapps/*
# ROOT.war => приложение доступно по "/" (ссылки в коде ведут на "/")
COPY --from=build /build/target/App42PaaS-Java-MySQL-Sample-0.0.1-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
