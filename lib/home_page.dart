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
  String search = "";

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
          const SizedBox(
            height: 10.0,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: const BorderRadius.all(
                Radius.circular(12.0),
              ),
              border: Border.all(
                width: 1.0,
                color: Colors.grey[400]!,
              ),
            ),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.search),
                ),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration.collapsed(
                      filled: true,
                      fillColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      hintText: "Search",
                    ),
                    onChanged: (value) {
                      search = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection("tugas").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text("Error"));
                }
                if (snapshot.data == null) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.data!.docs.isEmpty) {
                  return const Text("No Data");
                }

                final data = snapshot.data!;
                return ListView.separated(
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 3.0,
                    );
                  },
                  itemCount: data.docs.length,
                  padding: const EdgeInsets.all(12.0),
                  clipBehavior: Clip.hardEdge,
                  itemBuilder: (context, index) {
                    final task = data.docs[index].data() as Map;
                    task["id"] = data.docs[index].id;

                    if (search.isNotEmpty) {
                      if (!task["judul"]
                          .toString()
                          .toLowerCase()
                          .contains(search.toLowerCase())) {
                        return const SizedBox();
                      }
                    }

                    return Card(
                      elevation: 2,
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FormPage(
                                      tugas: task,
                                    )),
                          );
                        },
                        title: Text(task["judul"]),
                        subtitle: Text(task["deskripsi"]),
                        trailing: IconButton(
                          onPressed: () {
                            setState(() {
                              FirebaseServices().deleteTugas(docId: task['id']);
                            });
                          },
                          icon: const Icon(
                            Icons.delete_forever,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
