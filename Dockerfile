FROM alpine:latest

ARG JDK_VERSION=openjdk8
ARG JAR_ARG=my-application.jar
ENV JAR_FILE=${JAR_ARG}

RUN apk update && apk add ${JDK_VERSION}

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

HEALTHCHECK --interval=10s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:8080/ || exit 1

CMD /app/run.sh
