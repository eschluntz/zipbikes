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
        start__lt=now, stop__gt=now,
        bike__status='A')

    # get bikes
    bikes = []
    for avail in avails:
        bike = avail.bike
        bikes.append({
            'id': bike.id,
            'lat': bike.lat,
            'lon': bike.lon,
            'price': bike.price,
            'rating': bike.rating,
            #'pic': bike.picture.url,
            'stop':avail.stop
        })

    response = {'bikes':bikes}
    return JsonResponse(response)

def ask(request):
    """Asks for permission to rent a bike.
    expects: user_id, bike_id in post"""
    
    # expect user_id, bike_id
    data = request.POST
    user_id = data['user_id']
    bike_id = data['bike_id']

    result = is_valid_rental(user_id, bike_id)

    response = {'result':result}
    return JsonResponse(response)

def unlock(request):
    """unlock a bike. 
    expects: user_id, bike_id in post
    <X> confirm that rental is valid
    < > Generate key for lock
    <X> update bike status to rented
    < > create rental object"""

    data = request.POST
    user_id = data['user_id']
    bike_id = data['bike_id']
    now = datetime.datetime.now()

    # does user have permission
    if not is_valid_rental(user_id, bike_id):
        error = "User does not have permission to rent bike right now."
        response ={"error": error,
                    "success": False}
        return JsonResponse(response)

    # TODO generate actual TOTP
    key = generate_key(bike_id)

    # updating bike DB
    bike = Bike.objects.get(id=bike_id)
    bike.status = 'R'
    bike.save()

    # creating rental object
    rental = Rental(bike=bike, user_id=user_id, start=now)
    rental.save()

    # give key to user
    response = {"key": key,
                "success": True}
    return JsonResponse(response)

def lock(request):
    """Locks a bike and ends a rental
    expects: user_id, bike_id, lat, lon
    <X> confirm rental exists
    <X> update bike status
    <X> close rental
    < > generate key
    """
    data = request.POST
    user_id = data['user_id']
    bike_id = data['bike_id']
    lat = data['lat']
    lon = data['lon']
    now = datetime.datetime.now()

    # getting rental object
    rentals = Rental.objects.filter(
        user__id=user_id, 
        bike__id=bike_id,
        start__lt=now,
        stop=None)

    # check if rental is valid
    if len(rentals) != 1:
        error = "This rental doesn't seem to exist"
        response = {"error":error,
                    "success":False}
        return JsonResponse(response)
    rental = rentals[0]

    # updating bike status
    bike = Bike.objects.get(id=bike_id)
    bike.status = 'A'
    bike.lat = lat
    bike.lon = lon
    bike.save()

    # closing rental
    rental.stop = now
    rental.save()

    # giving key
    key = generate_key(bike_id)
    response = {"key": key,
                "success": True}
    return JsonResponse(response)


##### Utilities

def is_valid_rental(user_id, bike_id):
    """Checks whether a bike rental is valid right now"""
    now = datetime.datetime.now()
    avails = Availability.objects.filter(
        bike_id=bike_id,
        start__lt=now, stop__gt=now,
        bike__status='A')

    return len(avails) > 0

def generate_key(bike_id):
    """Generate a TOTP"""
    return "42"