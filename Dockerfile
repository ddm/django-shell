FROM alpine:3.5

ARG BUTTERFLY_VERSION=2.0.2

RUN apk --no-cache add --virtual runtime-dependencies \
      python \
      py-pip \
      zeromq \
      postgresql \
      bash &&\
    apk --no-cache add --virtual build-dependencies \
      git \
      ca-certificates \
      build-base \
      libffi-dev \
      libressl-dev \
      python-dev \
      postgresql-dev &&\
    pip install --upgrade pip &&\
    PATH=$PATH:/usr/bin pip install -U psycopg2 &&\
    pip install -U \
      requests \
      django \
      django_extensions \
      butterfly==${BUTTERFLY_VERSION} \
      notebook &&\
    echo "#!/usr/bin/env sh" > /usr/local/bin/notebook &&\
    echo "/usr/bin/jupyter notebook --ip=0.0.0.0 --no-browser --NotebookApp.token=''" >> /usr/local/bin/notebook &&\
    chmod +x /usr/local/bin/notebook

# Butterfly shell
EXPOSE 5757
# Jupyter notebook
EXPOSE 8888

CMD  butterfly.server.py --unsecure --host=0.0.0.0 --port=5757 --shell=bash
