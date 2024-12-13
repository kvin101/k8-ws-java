FROM openjdk:21

WORKDIR /usr/app/

COPY target/order-service-0.0.1-SNAPSHOT.jar order.jar

EXPOSE 8080

CMD ["java", "-jar", "order.jar"]