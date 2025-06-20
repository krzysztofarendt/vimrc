FROM alpine:latest

RUN apk update
RUN apk add git
RUN apk add vim

RUN git clone https://github.com/krzysztofarendt/vimrc /vimrc
WORKDIR /vimrc

RUN ./install_wsl.sh
ENV TERM=xterm-256color

WORKDIR /workdir
CMD ["vim"]
