========================
Docker django base image
========================

Docker base image for python (currently 2.7) django projects.
Multi-process container, managed by circusd. 
Django config managed with env vars.


Other configuration managed with envtpl (nginx, circusd).

Description
===========

Docker image intended for use as a base image for django apps

* See parent image https://registry.hub.docker.com/u/apsl/circusbase
* circus to control processes. http://circus.readthedocs.org/
* envtpl to setup config files on start time, based on environ vars. https://github.com/andreasjansson/envtpl
* Runs django via chaussette wsgi server (see `circus.d/django.ini.tpl`) https://github.com/APSL/docker-django/blob/master/circus.d/django.ini.tpl
* Runs celery worker if `-e RUN_CELERY=True` (see `circus.d/celery_worker.ini.tpl`) https://github.com/APSL/docker-django/blob/master/circus.d/celery_worker.ini.tpl
* Runs flower if `-e RUN_FLOWER=True` (see `circus.d/flower.ini.tpl`) https://github.com/APSL/docker-django/blob/master/circus.d/flower.ini.tpl

Ports
=====

* 80: nginx django app, serving static
* 8000: chaussette wsgi server direct
* 8084: flower
* 8888: circus httpd web if `-e CIRCUS_HTTP=True` (see https://registry.hub.docker.com/u/apsl/circusbase/)


Env vars:
=========

Run web worker  (default True)::

    -e RUN_WEB=True    

Run celery worker (default False)::

    -e RUN_CELERY=false    

Celery worker concurrency. If not defined, uses num of cpus.

    -e CELERY_WORKER_CONCURRENCY=4

Celery beat

    -e RUN_CELERYBEAT=False
    
Celery beat scheduler type: file or class (default file)::

    -e CELERYBEAT_SCHEDULE_TYPE=file
    
Celery beat scheduler file. (default /code/src/celerybeat-schedule)::

    -e CELERYBEAT_SCHEDULE_FILE=/code/src/celerybeat-schedule
    
Celery beat scheduler class. (default djcelery.schedulers.DatabaseScheduler)::

    -e CELERYBEAT_SCHEDULE_CLASS=djcelery.schedulers.DatabaseScheduler

Celery Flower.

    -e RUN_FLOWER=False

Flower basic auth. If not defined, no auth

    -e FLOWER_BASIC_AUTH=myuser:mypasswd

Flower Oauth. If defined:

    -e FLOWER_AUTH=.*@apsl.net


... And all your django standar settings.


Example django Dockerfile based on apsl/django: 
===============================================

    FROM apsl/django

    # requirements
    ADD requirements.txt /tmp/requirements.txt
    RUN su -c "pew-in env pip install -r /tmp/requirements.txt" django

    # add code
    ADD src /code/src
    RUN chown django.django /code/src -R

    # collectstatic
    RUN su -c "pew-in env python manage.py collectstatic --noinput" django
