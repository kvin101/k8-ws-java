FROM nginx:latest

WORKDIR /usr/share/

COPY index.html .

RUN "sudo apt update"

EXPOSE 8085

CMD ["nginx"]