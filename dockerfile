FROM maven:3.8.8-openjdk-8 AS build
WORKDIR /app

COPY pom.xml .
COPY src ./src

RUN mvn clean package

FROM openjdk:8-jre-alpine
WORKDIR /app

COPY --from=build /app/target/jb-hello-world-maven-0.2.0.jar ./app.jar

CMD ["java", "-jar", "app.jar"]
