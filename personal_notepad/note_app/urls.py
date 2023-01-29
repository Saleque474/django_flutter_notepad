from django.urls import path , include
from . import views


urlpatterns=[
    path("createNote/",views.CreateNoteAPI.as_view()),
    path("getNote/",views.getNote),
    path("getListOfNotes/",views.NotesAPI.as_view()),
    path("deleteUpdateNote/<pk>/",views.NoteRetrieveUpdateDestroyAPIView.as_view()),
    path("deleteNote/",views.deleteNote),
]