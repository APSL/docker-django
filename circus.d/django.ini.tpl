[watcher:django]
cmd = chaussette --fd $(circus.sockets.django) wsgi.application
numprocesses = 4
use_sockets = True
uid = django
gid = django
working_dir = /code/src
virtualenv = /code/env
copy_env = True
#stdout_stream.class = FancyStdoutStream
#stdout_stream.color = green
{% if (RUN_WEB | default('True')) == 'False' %}
autostart = False
{% endif %}

[socket:django]
host = 0.0.0.0
port = 8000
