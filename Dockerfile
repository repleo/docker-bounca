FROM debian:8.4
MAINTAINER Jeroen Arnoldus "jeroen@repleo.nl"


ENV BOUNCA_SRC=bounca
ENV BOUNCA_SRVHOME=/srv/www
ENV BOUNCA_SRVPROJ=/srv/www/bounca

# Update the default application repository sources list
RUN apt-get update && apt-get -y upgrade


RUN apt-get install -y python3.4 python3.4-dev python3-setuptools git
RUN apt-get install -y gcc
RUN apt-get install -y libpq-dev
RUN easy_install-3.4 pip



WORKDIR $BOUNCA_SRVHOME
RUN mkdir media static logs
RUN git clone --branch v0.1.0 https://github.com/repleo/bounca.git $BOUNCA_SRVPROJ


# Install Python dependencies
RUN pip3.4 install -r $BOUNCA_SRVPROJ/requirements.txt
RUN pip3.4 install gunicorn==19.3.0

RUN python3 /srv/www/bounca/manage.py collectstatic --noinput

RUN mkdir -p /etc/bounca
COPY main.ini /etc/bounca/main.ini

