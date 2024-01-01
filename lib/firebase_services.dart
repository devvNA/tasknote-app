import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServices {
  //Method untuk melakukan create tugas
  Future createTugas({
    required String judul,
    required String deskripsi,
  }) async {
    try {
      await FirebaseFirestore.instance.collection("tugas").add({
        "judul": judul,
        "deskripsi": deskripsi,
      });
    } catch (e) {
      rethrow;
    }
  }

  //Method untuk melakukan update tugas
  Future updateTugas({
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
  Future deleteTugas({
    required String docId,
  }) async {
    try {
      await FirebaseFirestore.instance.collection("tugas").doc(docId).delete();
    } catch (e) {
      rethrow;
    }
  }
}
