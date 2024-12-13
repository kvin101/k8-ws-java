FROM openjdk:21

WORKDIR /usr/app/

COPY target/inventory-service-0.0.1-SNAPSHOT.jar inventory.jar

EXPOSE 8082

CMD ["java", "-jar", "inventory.jar"]