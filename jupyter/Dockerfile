FROM python:3.7-slim

WORKDIR /src

RUN pip install jupyterlab

CMD jupyter lab --no-browser --ip 0.0.0.0 --port 9999 --NotebookApp.token=xyz --allow-root