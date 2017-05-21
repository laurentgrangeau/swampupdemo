FROM python:3.6-alpine

COPY requirements.txt /tmp/
ENV PYTHONPATH /usr/work/
RUN pip install -r /tmp/requirements.txt
COPY swagger_server /usr/work/swagger_server

EXPOSE 8080

ENTRYPOINT ["python", "-m", "swagger_server"]
