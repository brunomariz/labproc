
FROM ubuntu:latest
WORKDIR /root/src
COPY ./arm-utils_1.0.2_all.deb .
RUN apt update -y && apt upgrade -y
RUN apt install -y ./arm-utils_1.0.2_all.deb