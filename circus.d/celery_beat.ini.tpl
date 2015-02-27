[watcher:celery_beat]
cmd = celery 
args = -A {{CELERY_APP | default('main')}} beat {% if CELERYBEAT_SCHEDULE_TYPE =='file' %}-s {{ CELERYBEAT_SCHEDULE_FILE | default('/code/src/celerybeat-schedule')}}{% endif %} {% if CELERYBEAT_SCHEDULE_TYPE =='class' %}-S {{ CELERYBEAT_SCHEDULE_CLASS | default('djcelery.schedulers.DatabaseScheduler')}}{% endif %} --loglevel={{ CELERY_LOGLEVEL | default('INFO')}}
numprocesses = 1
use_sockets = False
uid = django
gid = django
working_dir = /code/src
virtualenv = /code/env
copy_env = True
autostart = {{ RUN_CELERYBEAT | default('False') }}
