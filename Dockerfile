FROM openjdk:17
ADD target/*.jar biom.jar
EXPOSE 8087
CMD java -jar biom.jar