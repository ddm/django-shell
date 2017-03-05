FROM alpine:latest

RUN apk add --update --no-cache ca-certificates &&\
    apk add --update build-base libffi-dev libressl-dev zeromq py-pip python-dev postgresql-dev bash &&\
    pip install --upgrade pip &&\
    PATH=$PATH:/usr/bin pip install -U psycopg2 &&\
    pip install -U requests django butterfly notebook &&\
    echo "#!/usr/bin/env sh" > /usr/local/bin/notebook &&\
    echo "/usr/bin/jupyter notebook --ip=0.0.0.0 --no-browser --NotebookApp.token=''" >> /usr/local/bin/notebook &&\
    chmod +x /usr/local/bin/notebook

# Butterfly shell
EXPOSE 5757
# Jupyter notebook
EXPOSE 8888

CMD ["butterfly.server.py", "--unsecure", "--host=0.0.0.0", "--port=5757", "--shell=bash"]
