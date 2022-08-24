FROM apache/superset:latest

USER root

#RUN pip install apache-superset[druid]

RUN pip install pydruid
RUN pip install pydruid[cli]
RUN pip install trino

#RUN npm i @superset-ui/legacy-preset-chart-kepler

USER superset

COPY ./superset_config.py /app/pythonpath/superset_config.py

RUN export FLASK_APP=superset
RUN superset fab create-admin --username admin --firstname Superset --lastname Admin --email admin@superset.com --password admin 
RUN superset db upgrade
RUN superset init

#RUN superset load_examples

