# Generated by Django 5.0.3 on 2024-05-25 21:26

from django.db import migrations, models


class Migration(migrations.Migration):
    dependencies = [
        ("orders", "0003_reserveresponse"),
    ]

    operations = [
        migrations.AddField(
            model_name="customer",
            name="phone",
            field=models.CharField(default=1234568765, max_length=13),
            preserve_default=False,
        ),
    ]
