FROM python:3.6.1-alpine

ARG PROJECT

WORKDIR /deploy/app
RUN mkdir /etc/pip
COPY pip.conf /etc/pip.conf

RUN pip3 install $PROJECT

EXPOSE 8080

ENTRYPOINT ["python3", "-m", "$PROJECT"]