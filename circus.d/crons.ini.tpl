[watcher:cron]
cmd = /usr/sbin/cron
args = -f
copy_env = True
use_sockets = False
singleton = True
autostart = {{ DJANGO_CRONS | default('False') }}
