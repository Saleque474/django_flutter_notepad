import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notepad_frontend/api/auth/auth_api.dart';
import 'package:notepad_frontend/api/note/note_api.dart';
import 'package:notepad_frontend/models/note_model.dart';
import 'package:notepad_frontend/models/user_models.dart';
import 'package:notepad_frontend/pages/home/create_note_scren.dart';
import 'package:notepad_frontend/pages/home/update_note_screen.dart';
import 'package:notepad_frontend/pages/login_page.dart';

import '../../models/user_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    User user = context.read<UserCubit>().state;
    return Scaffold(
      backgroundColor: Color(0xFFB7E5FB),
      appBar: AppBar(
        title: Text(
            "Home of ${user.first_name} ${user.last_name} ${user.nickname}"),
        actions: [
          OutlinedButton(
              onPressed: () async {
                await logOut(user.token!);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => SignInPage()),
                    (route) => false);
              },
              child: Text(
                "Logout",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: FutureBuilder<List<Note>>(
          future: getNotes(user),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            List<Note> notes = snapshot.data!;
            return GridView.count(crossAxisCount: 2, children: [
              ...notes.map((note) {
                return InkWell(
                  onLongPress: () async {
                    String a = await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              content: Text("Do you want to delete note?"),
                              actions: [
                                OutlinedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop("confirm");
                                  },
                                  child: Text("Confirm"),
                                ),
                                OutlinedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop("cancel");
                                  },
                                  child: Text("Cancel"),
                                ),
                              ],
                            ));
                    if (a == "confirm") {
                      var b = await deleteNote(user, note.id);
                      if (b) {
                        await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  content: Text("Note Successfully Deleted"),
                                ));
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => HomePage()),
                            (route) => false);
                      } else {
                        await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  content: Text("Something went wrong"),
                                ));
                      }
                    }
                  },
                  onTap: () async {
                    // Note? note_ = await getNote(user, note.id);

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => UpdateNoteScreen(note: note),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(children: [
                      Text(note.title),
                      Text(note.author.nickname),
                      Text(
                        note.note.length > 20
                            ? note.note.substring(0, 20) + "..."
                            : note.note,
                      ),
                    ]),
                  ),
                );
              }).toList(),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CreateNoteScreen()));
                },
                child: Container(
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.add),
                ),
              )
            ]);
          }),
    );
  }
}
