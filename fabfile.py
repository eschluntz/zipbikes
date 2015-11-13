import os.path
from fabric.api import *

def ocean():
    env.hosts = ['107.170.6.59']
    env.user = 'django'

def pull():
    run('cd /home/django/zipbikes; git pull;') # runs the command on the remote environment 

def enter():
    run('cd /home/django/zipbikes/server/; source env/bin/activate;')

def sync():
    run('cd /home/django/zipbikes/server/zipbikes; ./manage.py syncdb')
    run('cd /home/django/zipbikes/server/zipbikes; ./manage.py migrate')

def reload():
    run('service gunicorn restart')

def deploy():
    pull()
    enter()
    sync()
    reload()