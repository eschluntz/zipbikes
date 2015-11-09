# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0002_auto_20151108_2302'),
    ]

    operations = [
        migrations.AddField(
            model_name='bike',
            name='secret',
            field=models.CharField(max_length=100, null=True, blank=True),
        ),
        migrations.AlterField(
            model_name='bike',
            name='status',
            field=models.CharField(default=b'A', max_length=1, choices=[(b'A', b'Available'), (b'B', b'Broken'), (b'M', b'Missing'), (b'R', b'Rented')]),
        ),
    ]
