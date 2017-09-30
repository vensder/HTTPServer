# Simple HTTP Server in Java in a Docker

Just for CI Pipeline testing.

## Build a jar file:

```bash
javac -d classes/ source/HTTPServer.java 
cd classes/
jar cvfm HTTPServer.jar manifest.txt *.class
java -jar HTTPServer.jar
```

## Build and Run a Docker container:

```bash
docker build -t http-server .
docker run -p 8000:8000 http-server 
```

## Test:

http://localhost:8000/java
