import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SendMail extends StatefulWidget {
  const SendMail({Key? key}) : super(key: key);

  @override
  State<SendMail> createState() => _SendMailState();
}

class _SendMailState extends State<SendMail> {
  TextEditingController mailController = TextEditingController();

  void sendMail() async {
    const apiUrl = 'http://localhost:3000/send-mail';
    final requestBody = {
      'recipientEmail': mailController.text,
    };
     try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        print('E-posta başarıyla gönderildi.');
      } else {
        print('E-posta gönderme xatasi: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Hata: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: mailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: sendMail,
              child: const Text('Hi, please send me a mail', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
            ),
          ],
        ),
      ),
    );
  }
}
