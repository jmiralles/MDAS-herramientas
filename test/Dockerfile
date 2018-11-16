FROM python:3.6-alpine

COPY requirements.txt /

RUN pip install -r /requirements.txt

ADD test_python.py /
CMD [ "python", "./test_python.py" ]


#CMD ["./test_python.py"]
#ENTRYPOINT [ "test.sh" ]