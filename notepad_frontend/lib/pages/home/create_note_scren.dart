import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notepad_frontend/api/note/note_api.dart';
import 'package:notepad_frontend/models/user_cubit.dart';
import 'package:notepad_frontend/models/user_models.dart';
import 'package:notepad_frontend/pages/home/home.dart';

class CreateNoteScreen extends StatefulWidget {
  const CreateNoteScreen({super.key});

  @override
  State<CreateNoteScreen> createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  late User user;
  @override
  void initState() {
    user = context.read<UserCubit>().state;
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Note"),
        actions: [
          OutlinedButton(
              onPressed: () async {
                if (titleController.text.isNotEmpty &&
                    noteController.text.isNotEmpty) {
                  var a = await createNote(
                    user,
                    titleController.text,
                    noteController.text,
                  );
                  if (a) {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => HomePage()),
                        (route) => false);
                  }
                }
              },
              child: Text(
                "Create",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: Column(children: [
        Text("Title"),
        TextField(
          maxLines: 1,
          controller: titleController,
          decoration: InputDecoration(border: OutlineInputBorder()),
        ),
        Text("Note"),
        TextField(
          controller: noteController,
          maxLines: 50,
          minLines: 10,
          decoration: InputDecoration(border: OutlineInputBorder()),
        ),
      ]),
    );
  }
}
