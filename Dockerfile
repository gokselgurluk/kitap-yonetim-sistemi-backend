# Build aşaması
FROM maven:3.8.4-openjdk-17 AS build

# Çalışma dizini
WORKDIR /app

# pom.xml dosyasını kopyala
COPY ./pom.xml /app

# src dizinini kopyala
COPY ./src /app/src

# Maven ile projeyi derle
RUN mvn clean package -Dmaven.test.skip=true

# Çalışma aşaması
FROM openjdk:17-jdk

# Çalışma dizini
WORKDIR /app

# Derlenmiş JAR dosyasını kopyala
COPY --from=build /app/target/*.jar app.jar

# Uygulama için portu aç
EXPOSE 8080

# Uygulamayı başlat
CMD ["java", "-jar", "app.jar"]