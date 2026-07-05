FROM maven:3.9-eclipse-temurin-17 AS build

WORKDIR /app

COPY pom.xml .

RUN mvn -B dependency:go-offline

FROM eclipse-temurin:17-jre-alpine AS runtime

WORKDIR /app


RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

COPY --from=build /app/target/app.jar /app/app.jar

ENTRYPOINT ["java", "-jar", "/app/app.jar"]
