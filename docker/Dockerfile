
FROM ubuntu:latest
WORKDIR /root/src
COPY . .
RUN apt update -y && apt upgrade -y
RUN apt install -y ./arm-utils_1.0.2_all.deb

RUN dpkg --add-architecture i386
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y gcc-multilib
RUN apt-get install -y libncurses5:i386
RUN apt-get install -y libncurses5
RUN apt-get update -y
RUN apt-get install -y qemu-system-arm qemu-efi
RUN apt-get install -y ./arm-e7t.deb
