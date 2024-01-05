// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:praktikum_modul_12/firebase_services.dart';
import 'package:praktikum_modul_12/form_page.dart';
import 'package:praktikum_modul_12/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  onLogout() async {
    await FirebaseServices().logout();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FormPage()),
          );
        },
      ),
      appBar: AppBar(
        title: const Text("Tugas App"),
        actions: [
          IconButton(
            onPressed: () {
              onLogout();
            },
            icon: const Icon(
              Icons.logout,
              size: 25.0,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("tugas").snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return ListView.separated(
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 8.0,
                    );
                  },
                  padding: const EdgeInsets.all(12.0),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final tugas = snapshot.data!.docs[index].data() as Map;
                    tugas["id"] = snapshot.data!.docs[index].id;

                    return Card(
                      elevation: 1.5,
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FormPage(
                                      tugas: tugas,
                                    )),
                          );
                        },
                        title: Text(tugas["judul"]),
                        subtitle: Text(tugas["deskripsi"]),
                        trailing: IconButton(
                          onPressed: () async {
                            await FirebaseServices()
                                .deleteTugas(docId: tugas["id"]);
                            setState(() {});
                          },
                          icon: const Icon(
                            Icons.delete,
                            size: 24.0,
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ))
        ],
      ),
    );
  }
}
