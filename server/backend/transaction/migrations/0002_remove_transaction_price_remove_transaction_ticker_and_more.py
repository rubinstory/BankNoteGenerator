# Generated by Django 4.0.1 on 2022-01-17 13:25

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('transaction', '0001_initial'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='transaction',
            name='price',
        ),
        migrations.RemoveField(
            model_name='transaction',
            name='ticker',
        ),
        migrations.AddField(
            model_name='transaction',
            name='avgFillPrice',
            field=models.FloatField(default=0),
        ),
        migrations.AddField(
            model_name='transaction',
            name='createdAt',
            field=models.CharField(default='', max_length=100),
        ),
        migrations.AddField(
            model_name='transaction',
            name='market',
            field=models.CharField(default='', max_length=10),
        ),
        migrations.AddField(
            model_name='transaction',
            name='side',
            field=models.CharField(default='', max_length=10),
        ),
        migrations.AddField(
            model_name='transaction',
            name='size',
            field=models.FloatField(default=0),
        ),
    ]