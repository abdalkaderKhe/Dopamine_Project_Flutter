import 'package:eisenhower_matrix/controller/notes_controller.dart';
import 'package:eisenhower_matrix/model/note_app/note.dart';
import 'package:eisenhower_matrix/services/db/database.dart';
import 'package:eisenhower_matrix/ui/pages/note_app/notes_page.dart';
import 'package:eisenhower_matrix/ui/widgets/note_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddEditNotePage extends StatefulWidget {
  final Note? note;
  final int index;
  const AddEditNotePage({Key? key, this.note, required this.index,}) : super(key: key);
  @override
  _AddEditNotePageState createState() => _AddEditNotePageState();
}

class _AddEditNotePageState extends State<AddEditNotePage> {

  final _formKey = GlobalKey<FormState>();

  late bool isImportant;
  late int number;
  late String title;
  late String description;

  NotesController notesController = NotesController();

  @override
  void initState() {
    super.initState();

    isImportant = widget.note?.isImportant ?? false;
    number = widget.note?.number ?? 0;
    title = widget.note?.title ?? '';
    description = widget.note?.description ?? '';

  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.grey.shade50,
    appBar: AppBar(
      actions: [buildButton()],
    ),
    body: Form(
      key: _formKey,
      child: NoteFormWidget(

        isImportant: isImportant,

        number: number,

        title: title,

        description: description,

        onChangedImportant: (isImportant) => setState(() => this.isImportant = isImportant),

        onChangedNumber: (number) => setState(() => this.number = number),

        onChangedTitle: (title) => setState(() => this.title = title),

        onChangedDescription: (description) => setState(() => this.description = description),

      ),
    ),
  );

  Widget buildButton()
  {
    final isFormValid = title.isNotEmpty && description.isNotEmpty;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: isFormValid ? null : Colors.blueAccent,
        ),
        onPressed: addOrUpdateNote,
        child: const Text('حفظ',style: TextStyle(fontFamily: "Almarai",fontWeight: FontWeight.w900),),
      ),
    );
  }

  void addOrUpdateNote() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {

      final isUpdating = widget.note != null;

      if (isUpdating)
      {
        await updateNote();
      }
      else
      {
        await addNote();
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NotesPage()),
      );
    }
  }

  Future updateNote() async {
    print("updateNote");
    final note = widget.note!.copy(
      isImportant: isImportant,
      number: number,
      title: title,
      description: description,
    );
    //await MyDatabase.localDatabase.update(note);
    Provider.of<NotesController>(context, listen: false).updateNote(note,widget.index);
    //Provider.of<NotesController>(context, listen: false).getAllNotes();
  }

  Future addNote() async {
    print("addNote");
    final note = Note(
      title: title,
      isImportant: true,
      number: number,
      description: description,
      createdTime: DateTime.now(),
    );
    Provider.of<NotesController>(context, listen: false).addNote(note);
    //notesController.addNote(note);
    //await MyDatabase.localDatabase.insert(note);
    //await NotesDatabase.instance.create(note);
  }
}
