FROM ubuntu:16.04

RUN apt-get update && \
    apt-get install wget -y

RUN wget https://raw.githubusercontent.com/b0th/wall.sh/main/wall.sh

ENTRYPOINT [ "bash" , "wall.sh" ]