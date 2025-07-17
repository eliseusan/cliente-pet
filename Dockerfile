# Multi-stage build para otimizar o tamanho da imagem final
FROM maven:3.8.8-eclipse-temurin-11 AS build

# Define o diretório de trabalho
WORKDIR /app

# Copia o arquivo pom.xml primeiro para aproveitar o cache do Docker
COPY pom.xml .

# Baixa as dependências do Maven (cache layer)
RUN mvn dependency:go-offline -B

# Copia o código fonte
COPY src ./src

# Compila a aplicação
RUN mvn clean package -DskipTests

# Stage de produção - imagem final mais leve
FROM openjdk:11-jre-slim

# Define o diretório de trabalho
WORKDIR /app

# Copia o JAR compilado do stage anterior
COPY --from=build /app/target/cliente-pet-0.0.1-SNAPSHOT.jar app.jar

# Expõe a porta 8080 (padrão do Spring Boot)
EXPOSE 8080
# Define variáveis de ambiente para a JVM
ENV JAVA_OPTS="-Xmx512m -Xms256m"

# Comando para executar a aplicação
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]
