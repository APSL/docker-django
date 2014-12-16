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


Env vars:

Run web worker  (default True)::

    -e RUN_WEB=True    

Run celery worker (default False)::

    -e RUN_CELERY_WORKER=false    
    -e CELERY_WORKER_CONCURRENCY=None
