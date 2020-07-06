FROM zenika/kotlin:1.1.61-jdk11

ENV APPLICATION_USER ktor
RUN adduser --no-create-home -gecos '' --disabled-password $APPLICATION_USER

RUN mkdir /app
COPY resources /app/
COPY ./build/libs/my-application.jar /app/my-application.jar

RUN chown -R $APPLICATION_USER:$APPLICATION_USER /app

WORKDIR /app
EXPOSE 8080

USER $APPLICATION_USER

#CMD ["java", "-server", "-XX:+UnlockExperimentalVMOptions", "-XX:InitialRAMFraction=2", "-XX:MinRAMFraction=2", "-XX:MaxRAMFraction=2", "-XX:+UseG1GC", "-XX:MaxGCPauseMillis=100", "-XX:+UseStringDeduplication", "-jar", "my-application.jar"]
CMD ["java", "-server", "-jar", "my-application.jar"]