

```bash
cd source/
javac -d ../classes HTTPServer.java 
cd ../classes/
jar cvfm HTTPServer.jar manifest.txt *.class
java -jar HTTPServer.jar
```

