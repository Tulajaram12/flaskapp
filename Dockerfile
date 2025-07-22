##BASE IMAGE
FROM python:3.10-slim 

###USER
RUN useradd tulaja && usermod -s /bin/bash tulaja && mkdir /home/tulaja && chown tulaja:tulaja /home/tulaja
USER tulaja

###SETTING WORKDIR
WORKDIR /app

####COPYING CODE FROM LOCAL TO CONTAINER
COPY . .

###INSTALLING DEPENDENCIES OF CODE
RUN pip install -r requirements.txt

###EXPOSING THE PORT
EXPOSE 5000

###RUN THE CODE
CMD ["python3", "run.py"]


