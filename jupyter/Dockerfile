FROM python:3.7-slim

WORKDIR /src

COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

COPY model model
COPY main.py main.py

CMD jupyter notebook --no-browser --ip 0.0.0.0 --port 9999 --NotebookApp.token=xyz --allow-root