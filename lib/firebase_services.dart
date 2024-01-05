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
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
      }
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
      if (e.code == 'user-not-found') {
        log('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        log('Wrong password provided for that user.');
      }
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
