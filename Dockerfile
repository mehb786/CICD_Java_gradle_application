FROM openjdk:8 as base
WORKDIR /app
COPY . .
RUN  chmod 777 gradlew
RUN ./gradlew build

FROM tomcat
WORKDIR /app
COPY --from=base /app/build/libs/*.jar /app
RUN rm -rf ROOT.war && mv /app/build/libs/*.jar /app/ROOT.jar
CMD ["java",'-jar',"/app/ROOT.jar"]
