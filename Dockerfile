FROM mcr.microsoft.com/dotnet/runtime:7.0

LABEL maintainer="timstephens24@gmail.com"

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

ARG FOLDER_NAME

RUN mkdir /db
RUN mkdir /config
RUN mkdir /data

COPY ${FOLDER_NAME} /libation
COPY liberate.sh .

CMD ["./liberate.sh"]
