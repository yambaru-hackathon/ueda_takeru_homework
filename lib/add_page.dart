// ignore_for_file: library_private_types_in_public_api, deprecated_member_use, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State {
  String first = '';
  String last = '';
  late int bornYear = DateTime.now().year;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        TextField(
          decoration: const InputDecoration(hintText: 'first'),
          onChanged: (text) {
            first = text;
          },
        ),
        TextField(
          decoration: const InputDecoration(hintText: 'last'),
          onChanged: (text) {
            last = text;
          },
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Select Year:'),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Select Year'),
                      content: SizedBox(
                        // Need to use container to add size constraint.
                        width: 300,
                        height: 300,
                        child: YearPicker(
                          firstDate: DateTime(DateTime.now().year - 100, 1),
                          lastDate: DateTime(DateTime.now().year + 100, 1),
                          initialDate: DateTime.now(),
                          selectedDate: DateTime(bornYear),
                          onChanged: (DateTime dateTime) {
                            setState(() {
                              bornYear = dateTime.year;
                            });
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    );
                  },
                );
              },
              child: Text('$bornYear'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ElevatedButton(
            onPressed: () async {
              await _addToFirebase(context);
              Navigator.pop(context);
            },
            child: const Text('追加する'))
      ]),
    );
  }

  Future _addToFirebase(BuildContext context) async {
    final db = FirebaseFirestore.instance;
    final user = <String, dynamic>{
      "first": first,
      "last": last,
      "born": bornYear,
    };

    await db.collection("users").add(user);
  }
}
