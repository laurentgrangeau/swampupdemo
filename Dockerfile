FROM python:3.6.1-alpine

ARG project

WORKDIR /deploy/app
RUN mkdir /etc/pip
COPY pip.conf /etc/pip.conf

RUN pip3 install $project

EXPOSE 8080

RUN echo "python3 -m $project" > entrypoint.sh && chmod +x entrypoint.sh

ENTRYPOINT [ "sh", "/deploy/app/entrypoint.sh" ]
