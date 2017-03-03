FROM python:2-alpine

RUN apk add --update build-base libffi-dev openssl-dev python-dev zeromq &&\
    pip install -U requests django butterfly notebook

# Butterfly shell
EXPOSE 57575
# Jupyter notebook
EXPOSE 8888

CMD ["butterfly.server.py", "--unsecure", "--host=0.0.0.0"]
