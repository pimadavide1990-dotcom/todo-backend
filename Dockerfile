# Fase 1: Build dell'applicazione con Maven
FROM eclipse-temurin:17-jdk-jammy AS build
WORKDIR /app
COPY . .
RUN chmod +x mvnw
RUN ./mvnw clean package -DskipTests -Djar.finalName=app

# Fase 2: Esecuzione dell'applicazione
FROM eclipse-temurin:17-jre-jammy
WORKDIR /app
COPY --from=build /app/target/app.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]