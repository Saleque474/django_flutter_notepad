from rest_framework import serializers
from .models import Note
from django.contrib.auth import get_user_model

class AuthorSerializer(serializers.ModelSerializer):
    class Meta:
        model=get_user_model()
        fields=["id","nickname","profile_picture","email"]

class NoteSerializer(serializers.ModelSerializer):
    author=serializers.SerializerMethodField("get_author")
    class Meta:
        model=Note
        fields="__all__"
    def get_author(self,model:Note):
        return AuthorSerializer(model.author,many=False).data

class NoteSaveSerializer(serializers.ModelSerializer):
    class Meta:
        model=Note
        fields="__all__"