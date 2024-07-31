# Use a imagem oficial do Maven para compilar e empacotar a aplicação
FROM maven:3.8.5-openjdk-17-slim AS build
WORKDIR /app

# Copie o arquivo pom.xml e as dependências para a imagem
COPY pom.xml .
COPY src ./src

# Compile e empacote a aplicação
RUN mvn clean package -DskipTests

# Use uma imagem do JDK para rodar a aplicação
FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar

# Porta em que a aplicação será exposta
EXPOSE 8080

# Comando para iniciar a aplicação
ENTRYPOINT ["java", "-jar", "app.jar"]
