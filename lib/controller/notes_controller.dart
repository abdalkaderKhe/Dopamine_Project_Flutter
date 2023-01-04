import 'package:eisenhower_matrix/config/constants.dart';
import 'package:eisenhower_matrix/model/note_app/note.dart';
import 'package:eisenhower_matrix/services/db/database.dart';
import 'package:flutter/material.dart';

class NotesController extends ChangeNotifier{

   List<Note> notes = [];

   getAllNotes()async
   {
     notes = await fetchAllNotesFromDateBase();
     notifyListeners();
   }

   addNote(Note note)
   {
     addNoteTooDateBase(note);
     notes.add(note);
     notifyListeners();
   }

   updateNote(Note note,int index)
   {
     updateNoteTooDateBase(note);
     notes[index] = note;
     notifyListeners();
   }


   deleteNote(Note note, int index)
   {
     deleteNoteFromDateBase(note);
     notes.removeAt(index);
     notifyListeners();
   }

   deleteNoteFromDateBase(Note note)
   {
     MyDatabase.localDatabase.delete(note);
   }

   addNoteTooDateBase(Note note)
   {
     MyDatabase.localDatabase.insert(note);
   }

   updateNoteTooDateBase(Note note)async
   {
     MyDatabase.localDatabase.update(note);
   }

   Future<List<Note>> fetchAllNotesFromDateBase()async
   {
     List<Note> notes = [];
     MyDatabase.localDatabase.getAll('notes',dataBaseName).then((value){
       notes.addAll(value.cast());
     });
     return notes;
   }

}