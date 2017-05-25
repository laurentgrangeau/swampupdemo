FROM python:3.6.1-alpine

WORKDIR /deploy/app
COPY app /deploy/app

RUN pip3 install -r requirements.txt
RUN pip3 install gunicorn

EXPOSE 8080

ENTRYPOINT ["python", "-m", "swagger_server"]