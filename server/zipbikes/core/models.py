from django.db import models
from django.contrib.auth.models import User

class UserProfile(models.Model):
    """store any additional info about users"""
    user = models.OneToOneField(User)

    date_created = models.DateTimeField(auto_now_add=True)
    date_modified = models.DateTimeField(auto_now=True)

class Bike(models.Model):
    """store info on bikes"""
    owner = models.ForeignKey(User, related_name="bikes")
    price = models.FloatField(default=2)
    rating = models.FloatField(default=3.5)
    #picture = models.ImageField(null=True, blank=True)
    secret = models.CharField(max_length=100, null=True, blank=True)
    
    # changing
    STATUS_CHOICES = (
        ('A', 'Available'),
        ('B', 'Broken'),
        ('M', 'Missing'),
        ('R', 'Rented')
    )
    status = models.CharField(
        max_length=1, 
        choices=STATUS_CHOICES,
        default='A')
    lat = models.FloatField()
    lon = models.FloatField()

    date_created = models.DateTimeField(auto_now_add=True)
    date_modified = models.DateTimeField(auto_now=True)

class Rental(models.Model):
    """store info on rental occurances"""
    bike = models.ForeignKey(Bike, related_name="rentals")
    user = models.ForeignKey(User, related_name="rentals")

    # remember to update the in_use flag
    start = models.DateTimeField()
    stop = models.DateTimeField(null=True, blank=True)

class Availability(models.Model):
    """A specific time a bike is available for rent.
    Need to double check that"""

    bike = models.ForeignKey(Bike, related_name="availabilities")

    start = models.DateTimeField()
    stop = models.DateTimeField(null=True, blank=True)