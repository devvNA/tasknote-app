import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  //Method untuk melakukan registrasi
  Future<bool> registration(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      return false;
    }
  }

  //Method untuk melakukan login
  Future<bool> login({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      return false;
    }
  }

  //Method untuk melakukan logout
  Future logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      rethrow;
    }
  }

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
