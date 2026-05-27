FROM eclips-tamurin:23-JDK

WORKDIR /app

COPY target/*.jar /app.jar

ENTRYPOINT ["java" , "-jar"  ,"app.jar"]