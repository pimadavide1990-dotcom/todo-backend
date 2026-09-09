# Fase 1: Build dell'applicazione con Maven
FROM eclipse-temurin:17-jdk-jammy AS build
WORKDIR /app
COPY . .
RUN chmod +x mvnw
RUN ./mvnw clean package -DskipTests -X 2>&1 | tail -100
RUN echo "=== TARGET DIRECTORY ===" && ls -la /app/target/
RUN echo "=== JAR FILES ===" && find /app -name "*.jar" -type f

# Fase 2: Esecuzione dell'applicazione
FROM eclipse-temurin:17-jre-jammy
WORKDIR /app
COPY --from=build /app/target/demo-0.0.1-SNAPSHOT.jar demo-0.0.1-SNAPSHOT.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "demo-0.0.1-SNAPSHOT.jar"]