FROM python:3.6.1-alpine

WORKDIR /deploy/app
RUN mkdir ${HOME}/pip
COPY pip.ini ${HOME}/pip/pip.ini

RUN pip3 install swampup

EXPOSE 8080

ENTRYPOINT ["python", "-m", "swampup"]