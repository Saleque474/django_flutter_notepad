from django.db import models
from django.contrib.auth.models import AbstractUser
from django_resized import ResizedImageField
# Create your models here.

def upload_to( inst, filename ):
    return "/profile/"+str(filename)

class User(AbstractUser):
    username=models.CharField(max_length=55,
                              unique=False)
    nickname=models.CharField(max_length=55)
    profile_picture=ResizedImageField(upload_to=upload_to,null=True,blank=True)

    def __str__(self) -> str:
        return self.nickname+" : "+str(self.id )