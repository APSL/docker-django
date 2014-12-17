[watcher:flower]
cmd = flower -A {{CELERY_APP | default('main')}} --address=0.0.0.0 --port=8084 {% if FLOWER_BASIC_AUTH is defined %}--basic_auth={{FLOWER_BASIC_AUTH}}{% endif %} {% if FLOWER_AUTH is defined %}--auth={{FLOWER_AUTH}}{% endif %}
numprocesses = 1
use_sockets = False
uid = django
gid = django
working_dir = /code/src
virtualenv = /code/env
copy_env = True
autostart = {{ RUN_FLOWER | default('False') }}
