from django.shortcuts import render
from django.http import HttpResponse, JsonResponse
import json
import datetime
from .models import *

# core APIs for the app

def map(request):
    """Returns all data that needs to go on a map view"""
    data = request.POST
    now = datetime.datetime.now()

    # all open availibilities
    avails = Availability.objects.filter(
        start__lt=now, end__gt=now)

    response = {'foo':'bar'}
    return JsonResponse(response)

def ask(request):
    """Asks for permission to rent a bike"""
    response = {'foo':'bar'}
    return JsonResponse(response)

def action(request):
    """Lock or unlock a bike. This needs to be secure"""
    response = {'foo':'bar'}
    return JsonResponse(response)