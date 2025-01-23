FROM openjdk:21-jdk-slim AS build
VOLUME /tmp
COPY pom.xml .
COPY src ./src
RUN ./mvnw clean package -DskipTests

FROM openjdk:21-jre-slim
COPY --from=build target/*.jar app.jar
ENTRYPOINT ["java","-jar","/app.jar"]