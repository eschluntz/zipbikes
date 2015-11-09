# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0003_auto_20151109_0006'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='bike',
            name='picture',
        ),
    ]
