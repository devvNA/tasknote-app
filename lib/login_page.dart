// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:praktikum_modul_12/firebase_services.dart';
import 'package:praktikum_modul_12/home_page.dart';
import 'package:praktikum_modul_12/registration_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? email;
    String? password;

    onLogin() async {
      bool isSuccess = await FirebaseServices()
          .login(email: email ?? "", password: password ?? "");
      if (!isSuccess) {
        return log("error login");
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Email',
                    labelStyle: const TextStyle(
                      color: Colors.blueGrey,
                    ),
                    suffixIcon: const Icon(
                      Icons.email,
                    ),
                    helperText: 'Enter your email address',
                  ),
                  onChanged: (value) {
                    email = value;
                  },
                ),
                const SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Password',
                    labelStyle: const TextStyle(
                      color: Colors.blueGrey,
                    ),
                    suffixIcon: const Icon(
                      Icons.password,
                    ),
                    helperText: 'Enter your password',
                  ),
                  onChanged: (value) {
                    password = value;
                  },
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          onLogin();
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Belum punya akun?",
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegistrationPage()),
                        );
                      },
                      child: const Text("Daftar"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
