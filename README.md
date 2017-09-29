

```bash
javac -d classes/ source/HTTPServer.java 
cd classes/
jar cvfm HTTPServer.jar manifest.txt *.class
java -jar HTTPServer.jar
```

```bash
docker build -t http-server .
docker run -p 8000:8000 http-server 
```

http://localhost:8000/java
