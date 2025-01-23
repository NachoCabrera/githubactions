FROM openjdk:21-jdk-slim AS build
VOLUME /tmp
COPY .mvn/ .mvn/
COPY mvnw mvnw
COPY mvnw.cmd mvnw.cmd
COPY pom.xml .
COPY src ./src
RUN ./mvnw clean package -DskipTests

FROM openjdk:21-slim
COPY --from=build target/*.jar app.jar
ENTRYPOINT ["java","-jar","/app.jar"]