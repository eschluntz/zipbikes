from django.conf.urls import patterns, include, url
from django.views.generic.base import TemplateView

from . import views

urlpatterns = patterns('',
    url(r'^map/$', views.map),
    url(r'^ask/$', views.ask),
    url(r'^lock/$', views.lock),
    url(r'^unlock/$', views.unlock),
)