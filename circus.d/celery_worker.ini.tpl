[watcher:celery_worker]
cmd = celery 
args = -A {{CELERY_APP | default('main')}} worker  -E --loglevel={{ CELERY_LOGLEVEL | default('INFO')}} {% if CELERY_CONCURRENCY is defined %} -c {{CELERY_CONCURRENCY}} {% endif %}
numprocesses = 1
use_sockets = False
uid = django
gid = django
working_dir = /code/src
virtualenv = /code/env
copy_env = True
autostart = {{ RUN_CELERY | default('False') }}
