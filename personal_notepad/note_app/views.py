from django.shortcuts import render
from rest_framework.decorators import api_view
from rest_framework.response import Response
from .models import Note
from .serializers import NoteSaveSerializer,NoteSerializer
from rest_framework.generics import (CreateAPIView ,
                                     UpdateAPIView,
                                     DestroyAPIView,
                                     ListAPIView,
                                     RetrieveUpdateDestroyAPIView,
                                     
                                     ListCreateAPIView
                                     )


@api_view(["POST"])
def createNote(request):
    data=request.data.dict()
    print(request.user)
    print(data)
    data["author"]=request.user.id
    serializer=NoteSaveSerializer(data=data)
    if serializer.is_valid(raise_exception=True):
        note=serializer.save()
        return Response(NoteSerializer(note,many=False).data)
    return Response({})

class CreateNoteAPI(CreateAPIView):
    # queryset = None
    serializer_class = NoteSaveSerializer

class NotesAPI(ListCreateAPIView):
    serializer_class=NoteSerializer
    queryset = Note.objects.all()

    def get_queryset(self):
        queryset=Note.objects.filter(author=self.request.user)
        return queryset

class NoteRetrieveUpdateDestroyAPIView(RetrieveUpdateDestroyAPIView):
    serializer_class = NoteSaveSerializer
    queryset = Note.objects.all()

def getNote(request):
    pass
def getListOfNotes(request):
    pass
def updateNote(request):
    pass

def deleteNote(request):
    pass