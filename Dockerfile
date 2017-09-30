FROM openjdk:8-jdk-alpine
WORKDIR /tmp
COPY . /tmp/
RUN javac -d classes/ source/HTTPServer.java && \
	cd classes/ && \
	jar cvfm HTTPServer.jar manifest.txt *.class

FROM openjdk:8-jre-alpine
WORKDIR /
COPY --from=0 /tmp/classes/HTTPServer.jar /HTTPServer.jar
ENTRYPOINT ["java", "-Xmx256m", "-jar", "/HTTPServer.jar"]
EXPOSE 8000

