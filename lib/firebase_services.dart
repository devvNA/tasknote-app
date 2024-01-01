import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServices {
  //Membuat instance firestore
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  //Method untuk melakukan create tugas
  Future<void> createTugas({
    required String judul,
    required String deskripsi,
  }) async {
    try {
      await firestore.collection("tugas").add({
        "judul": judul,
        "deskripsi": deskripsi,
      });
    } catch (e) {
      rethrow;
    }
  }

  //Method untuk melakukan update tugas
  Future<void> updateTugas({
    required String docId,
    required String judul,
    required String deskripsi,
  }) async {
    try {
      await FirebaseFirestore.instance.collection("tugas").doc(docId).update({
        "judul": judul,
        "deskripsi": deskripsi,
      });
    } catch (e) {
      rethrow;
    }
  }

  //Method untuk melakukan delete tugas
  Future<void> deleteTugas({
    required String docId,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection("tugas")
          .doc(docId)
          .delete();
    } catch (e) {
      rethrow;
    }
  }
}
