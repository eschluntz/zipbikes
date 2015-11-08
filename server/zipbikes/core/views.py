from django.shortcuts import render
from django.http import HttpResponse, JsonResponse
import json
from .models import *

def map(request):
    """Returns all data that needs to go on a map view"""
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