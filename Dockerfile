##BASE IMAGE
FROM python:3.12-slim 

##UPDATING PACKAGES
RUN apt-get update -y && apt-get upgrade -y 

###USER
RUN useradd tulaja && usermod -s /bin/bash tulaja && mkdir /home/tulaja && chown tulaja:tulaja /home/tulaja
USER tulaja

###SETTING WORKDIR
WORKDIR /app

####COPYING CODE FROM LOCAL TO CONTAINER
COPY . .

###INSTALLING DEPENDENCIES OF CODE
RUN pip install -r requirements.txt 

### TO MITIGATE SECURITY VUNLERABILITIES ADDED
#RUN pip install "setuptools>=78.1.1" 



###EXPOSING THE PORT
EXPOSE 5000

###RUN THE CODE
CMD ["python3", "run.py"]


