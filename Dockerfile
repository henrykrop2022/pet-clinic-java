FROM openjdk:17
ADD target/*.jar biom.jar
EXPOSE 8080
CMD java -jar biom.jar