FROM openjdk:8-jre-alpine

COPY classes/HTTPServer.jar /HTTPServer.jar

ENTRYPOINT ["java", "-Xmx1024m", "-jar", "/HTTPServer.jar"]

EXPOSE 8000

