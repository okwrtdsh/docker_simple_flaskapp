FROM ubuntu:14.04

MAINTAINER okwrtdsh <okwrtdsh@gmail.com>

# RUN perl -p -i.orig -e 's/archive.ubuntu.com/mirrors.aliyun.com\/ubuntu/' /etc/apt/sources.list

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install language-pack-ja -y
RUN locale-gen ja_JP.UTF-8
RUN dpkg-reconfigure locales
RUN echo "Asia/Tokyo" > /etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata


RUN apt-get install -y -q --fix-missing wget curl git gcc build-essential
RUN apt-get install -y -q python3 python3-dev python3-pip
RUN apt-get install -y -q libssl-dev libatlas-dev libffi-dev
RUN apt-get install -y -q libatlas3-base libblas-dev libblas3 libatlas-base-dev libatlas-dev
RUN apt-get install -y -q gfortran liblapack-dev
RUN apt-get install -y -q nginx supervisor

RUN pip3 install -U pip setuptools
RUN pip3 install uwsgi


RUN apt-get install -y software-properties-common python-software-properties
RUN apt-get update
RUN add-apt-repository -y ppa:nginx/stable


ADD . /home/docker/code/


RUN echo "daemon off;" >> /etc/nginx/nginx.conf
RUN rm /etc/nginx/sites-enabled/default
RUN ln -s /home/docker/code/nginx-app.conf /etc/nginx/sites-enabled/
RUN ln -s /home/docker/code/supervisor-app.conf /etc/supervisor/conf.d/


RUN pip3 install -r /home/docker/code/conf/package.pip


expose 80
cmd ["supervisord", "-n"]

