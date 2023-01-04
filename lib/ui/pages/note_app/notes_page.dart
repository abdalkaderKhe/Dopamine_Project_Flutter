import 'package:eisenhower_matrix/controller/notes_controller.dart';
import 'package:eisenhower_matrix/model/note_app/note.dart';
import 'package:eisenhower_matrix/ui/pages/note_app/add_edit_note_page.dart';
import 'package:eisenhower_matrix/ui/pages/note_app/note_detail_page.dart';
import 'package:eisenhower_matrix/ui/widgets/note_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    //refreshNotes();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future refreshNotes() async {
    //setState(() => isLoading = true);
    //this.notes = await NotesDatabase.instance.readAllNotes();
    //setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      automaticallyImplyLeading : false,
      title: const Text('الملاحظات', style: TextStyle(fontSize: 24,color: Colors.black54,fontFamily: "Almarai",),),
      actions: const [Icon(Icons.search,color: Colors.grey,), SizedBox(width: 12)],
    ),

    body: Center(
      child:
         // isLoading
         // ? const CircularProgressIndicator()
         // : notes.isEmpty
         // ? const Text('لايوجد ملاحظات', style: TextStyle(color: Colors.black54, fontSize: 24,fontFamily: "Almarai",),
         // )
         // :
          buildNotes(),
    ),
    floatingActionButton: FloatingActionButton(
      backgroundColor: Colors.blueAccent,
      child: const Icon(Icons.add),
      onPressed: () async {
        await Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) =>AddEditNotePage(index: 0,)),
        );
        //refreshNotes();
      },
    ),
  );

  Widget buildNotes() => Consumer<NotesController>(builder: (context,notesDate,_){
    return StaggeredGridView.countBuilder(
      padding: const EdgeInsets.all(8),
      itemCount: notesDate.notes.length,
      staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
      crossAxisCount: 4,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      itemBuilder: (context, index) {
        final note = notesDate.notes[index];

        return GestureDetector(
          onTap: () async {
            await Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => NoteDetailPage(note: notesDate.notes[index], index: index,),
            ));
            //refreshNotes();
          },
          child: NoteCardWidget(note: note, index: index),
        );
      },
    );
  });
}
