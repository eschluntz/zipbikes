# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0001_initial'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='bike',
            name='broken',
        ),
        migrations.RemoveField(
            model_name='bike',
            name='in_use',
        ),
        migrations.AddField(
            model_name='bike',
            name='status',
            field=models.CharField(default=b'A', max_length=1, choices=[(b'A', b'Available'), (b'B', b'Broken'), (b'M', b'Missing'), (b'U', b'Used')]),
        ),
    ]
