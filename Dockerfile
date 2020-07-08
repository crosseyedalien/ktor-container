FROM alpine:latest

ARG JDK_VERSION=openjdk11
ARG JAR_ARG=my-application.jar
ENV JAR_FILE=${JAR_ARG}

RUN apk update
RUN apk add ${JDK_VERSION}

ENV APPLICATION_USER ktor
RUN adduser --no-create-home --gecos '' --disabled-password $APPLICATION_USER

RUN mkdir /app
COPY resources /app/
COPY ./build/libs/$JAR_ARG /app/$JAR_ARG
COPY ./src/run.sh /app/

RUN chown -R $APPLICATION_USER:$APPLICATION_USER /app

WORKDIR /app
EXPOSE 8080

USER $APPLICATION_USER

CMD ["/app/run.sh"]
