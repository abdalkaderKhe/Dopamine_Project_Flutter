import 'package:eisenhower_matrix/controller/notes_controller.dart';
import 'package:eisenhower_matrix/model/note_app/note.dart';
import 'package:eisenhower_matrix/services/db/database.dart';
import 'package:eisenhower_matrix/ui/pages/note_app/add_edit_note_page.dart';
import 'package:eisenhower_matrix/ui/pages/note_app/notes_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
class NoteDetailPage extends StatefulWidget {
  //final int noteId;
   final Note note;
   final int index;
   const NoteDetailPage({Key? key, required this.note, required this.index,}) : super(key: key);
  @override
  _NoteDetailPageState createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  //late Note note;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      actions: [editButton(), deleteButton()],
    ),
    body:
      Padding(
      padding:const EdgeInsets.all(12),
      child: ListView(
        padding:const EdgeInsets.symmetric(vertical: 18),
        children: [
          Text(
            widget.note.title,
            style:const TextStyle(
              color: Colors.grey,
              fontSize: 22,
              fontFamily: "Almarai",
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            DateFormat.yMMMd().format(widget.note.createdTime),
            style:const TextStyle(color: Colors.grey,fontFamily: "Almarai", fontWeight: FontWeight.w900,),
          ),
          const SizedBox(height: 24),
          Text(
            widget.note.description,
            style:const TextStyle(color: Colors.grey,fontFamily: "Almarai", fontWeight: FontWeight.w900, fontSize: 18),
          )
        ],
      ),
    ),
  );

  Widget editButton() => IconButton(
      icon:const Icon(Icons.edit_outlined,color: Colors.grey,),
      onPressed: () async {
        if (isLoading) return;
        await Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => AddEditNotePage(note: widget.note, index: widget.index,),
        ));
       // refreshNote();
      });

  Widget deleteButton() => IconButton(
    icon: const Icon(Icons.delete,color: Colors.grey,),
    onPressed: () async {
     // await MyDatabase.localDatabase.delete(widget.note);
      Provider.of<NotesController>(context, listen: false).deleteNote(widget.note,widget.index);
      //await NotesDatabase.instance.delete(widget.noteId);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NotesPage()),
      );
    },
  );
}
