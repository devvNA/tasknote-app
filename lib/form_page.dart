// ignore_for_file: must_be_immutable, unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:praktikum_modul_12/firebase_services.dart';

class FormPage extends StatefulWidget {
  FormPage({this.tugas, super.key});

  Map? tugas;

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? judul;
  String? deskripsi;
  bool get isEditMode => widget.tugas != null;

  onSave() async {
    if (isEditMode) {
      await FirebaseServices().updateTugas(
        docId: widget.tugas!["id"],
        judul: judul!,
        deskripsi: deskripsi!,
      );
    } else {
      await FirebaseServices().createTugas(
        judul: judul ?? "",
        deskripsi: deskripsi ?? "",
      );
    }
  }

  @override
  void initState() {
    if (isEditMode) {
      judul = widget.tugas!["judul"];
      deskripsi = widget.tugas!["deskripsi"];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20.0),
        child: ElevatedButton(
          onPressed: () {
            onSave();
            Navigator.pop(context);
          },
          child: const Text("Save"),
        ),
      ),
      appBar: AppBar(
        title: const Text("Form Page"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextFormField(
              initialValue: judul,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: "Judul",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                judul = value;
              },
            ),
            const SizedBox(
              height: 15.0,
            ),
            TextFormField(
              initialValue: deskripsi,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: "Deskripsi",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                deskripsi = value;
              },
            ),
          ],
        ),
      ),
    );
  }
}
