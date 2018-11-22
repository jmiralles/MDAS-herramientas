FROM python:alpine

COPY requirements.txt .

RUN pip install -r requirements.txt

ADD test_python.py .
ENTRYPOINT [ "python", "test_python.py" ]


#CMD ["./test_python.py"]
#ENTRYPOINT [ "test.sh" ]