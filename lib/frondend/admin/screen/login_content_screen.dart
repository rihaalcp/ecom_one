import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginContentPage extends StatefulWidget {
  const LoginContentPage({super.key});

  @override
  State<LoginContentPage> createState() => _LoginContentPageState();
}

class _LoginContentPageState extends State<LoginContentPage> {
  static const baseUrl = "http://localhost:5000";
  final logoUrl = TextEditingController();
  final logoText = TextEditingController();
  final description = TextEditingController();
  final heading = TextEditingController();
  final subHeading = TextEditingController();
  final emailLabel = TextEditingController();
  final emailPlaceholder = TextEditingController();
  final passwordLabel = TextEditingController();
  final passwordPlaceholder = TextEditingController();
  final rememberMe = TextEditingController();
  final forgotPassword = TextEditingController();
  final loginButton = TextEditingController();
  final googleButton = TextEditingController();
  final appleButton = TextEditingController();
  final signupText = TextEditingController();
  final signupButton = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final response = await http.get(
      Uri.parse("$baseUrl/admin/page/get-login-page"),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      logoUrl.text = data["logoUrl"] ?? "";
      logoText.text = data["logoText"] ?? "";
      description.text = data["description"] ?? "";
      heading.text = data["heading"] ?? "";
      subHeading.text = data["subHeading"] ?? "";
      emailLabel.text = data["emailLabel"] ?? "";
      emailPlaceholder.text = data["emailPlaceholder"] ?? "";
      passwordLabel.text = data["passwordLabel"] ?? "";
      passwordPlaceholder.text = data["passwordLabel"] ?? "";
      rememberMe.text = data["rememberMe"] ?? "";
      forgotPassword.text = data["forgotPassword"] ?? "";
      loginButton.text = data["loginButton"] ?? "";
      googleButton.text = data["googleButton"] ?? "";
      appleButton.text = data["appleButton"] ?? "";
      signupText.text = data["singupText"] ?? "";
      signupButton.text = data["signupButton"] ?? "";

      setState(() {});
    }
  }

  Future<void> saveData() async {
    await http.post(
      Uri.parse("$baseUrl/admin/page/save-login-page"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
          "logoUrl": logoUrl.text,
  "logoText": logoText.text,
  "heading": heading.text,
  "description": description.text,
  "subHeading": subHeading.text,
  "emailLabel": emailLabel.text,
  "emailPlaceholder": emailPlaceholder.text,
  "passwordLabel": passwordLabel.text,
  "passwordPlaceholder": passwordPlaceholder.text,
  "rememberMe": rememberMe.text,
  "forgotPassword":forgotPassword.text,
  "loginButton": loginButton.text,
  "googleButton": googleButton.text,
  "appleButton": appleButton.text,
  "signupText": signupText.text,
  "signupButton": signupButton.text
      }),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Saved"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login CMS"),
      ),
      body: SafeArea(
        child:SingleChildScrollView(
          padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: logoUrl,
              decoration: const InputDecoration(
                labelText: "Logo Url",
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: logoText,
              decoration: const InputDecoration(
                labelText: "Logo Text",
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: description,
              decoration: const InputDecoration(
                labelText: "Decription",
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: heading,
              decoration: const InputDecoration(
                labelText: "Heading",
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: subHeading,
              decoration: const InputDecoration(
                labelText: "Sub Heading",
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: emailLabel,
              decoration: const InputDecoration(
                labelText: "Email Label",
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: emailPlaceholder,
              decoration: const InputDecoration(
                labelText: "Email Placeholder",
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: passwordLabel,
              decoration: const InputDecoration(
                labelText: "Password Label",
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: passwordPlaceholder,
              decoration: const InputDecoration(
                labelText: "Password Placeholder",
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: rememberMe,
              decoration: const InputDecoration(
                labelText: "Remember Me",
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: forgotPassword,
              decoration: const InputDecoration(
                labelText: "Forgot Password",
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: loginButton,
              decoration: const InputDecoration(
                labelText: "Login Button",
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: googleButton,
              decoration: const InputDecoration(
                labelText: "Google Button",
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: appleButton,
              decoration: const InputDecoration(
                labelText: "Apple Button",
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: signupText,
              decoration: const InputDecoration(
                labelText: "SignUp Text",
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: signupButton,
              decoration: const InputDecoration(
                labelText: "SignUp Button",
              ),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: saveData,
              child: const Text("Save"),
            ),
          ],
        ),
      ),
      )
    );
  }
}