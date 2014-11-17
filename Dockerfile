FROM apsl/circusbase
MAINTAINER Bernardo Cabezas <bcabezas@apsl.net>

#nginx
RUN apt-get install nginx-full && apt-get clean

# Things required for a python/pip environment
RUN apt-get -y -q install git mercurial curl build-essential python python-dev python-distribute python-pip inetutils-ping dnsutils && apt-get clean

RUN \
   echo "deb http://archive.ubuntu.com/ubuntu trusty main universe restricted" > /etc/sources.list ;\
   echo "deb http://archive.ubuntu.com/ubuntu trusty-updates main restricted" >>/etc/apt/sources.list ;\
   apt-get update && apt-get clean
RUN apt-get -y -q install libpq-dev libxml2-dev libxslt1-dev libssl-dev && apt-get clean

# nodejs 
RUN \
    apt-get install nodejs npm && apt-get clean && \
    npm install -g less && \
    ln -sf /usr/bin/nodejs /usr/bin/node

# Upgrade pip
RUN \
    /usr/bin/pip --no-input install --upgrade pip;\
    /usr/local/bin/pip install virtualenv

#RUN pip install virtualenvwrapper
RUN pip install chaussette 

# django user and dirs
RUN \
    addgroup --system --gid 500 django;\
    adduser --system --shell /bin/bash --gecos 'Django app user' --uid 500 --gid 500 --disabled-password --home /code django ;\
    mkdir -p /data/media; mkdir -p /data/static ;\                             
    chown django.django /data -R 

# prepare user profile to activate virtualenv. This way  "su -l django" wil have virtualenv activated.
RUN \
    echo "PIP_REQUIRE_VIRTUALENV=true" >> /code/.profile ;\
    echo "PIP_RESPECT_VIRTUALENV=true" >> /code/.profile ;\
    su -l -c "virtualenv --no-site-packages ~/env" django ;\
    echo "source ~/env/bin/activate" >> /code/.profile
    # END RUN

ADD circus.d/nginx.ini /etc/circus.d/nginx.ini
ADD circus.d/django.ini /etc/circus.d/django.ini
ADD conf/nginx.conf /etc/nginx/nginx.conf
VOLUME /log

EXPOSE 8000 80
