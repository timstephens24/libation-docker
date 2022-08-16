FROM mcr.microsoft.com/dotnet/runtime:6.0

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

ARG FOLDER_NAME

RUN mkdir /db
RUN mkdir /config
RUN mkdir /data

COPY ${FOLDER_NAME} /libation
COPY liberate.sh .

CMD ["./liberate.sh"]
