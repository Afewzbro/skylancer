import 'package:flutter/material.dart';

class HesapAyarlariPage extends StatefulWidget {
  const HesapAyarlariPage({super.key});

  @override
  State<HesapAyarlariPage> createState() => _HesapAyarlariPageState();
}

class _HesapAyarlariPageState extends State<HesapAyarlariPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          'Hesap Ayarlari',
          style:  TextStyle(
            color: Colors.white,
            fontFamily: 'BalsamiqSans',
            fontSize: 24.0,
          ),
        ),
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Telefon Numarasi',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const TextField(
              decoration: InputDecoration(
                hintText: 'Telefon Numaranizi giriniz',
                border: UnderlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Sifre',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Sifrenizi giriniz',
                border: UnderlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24.0),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  // Handle update profile action
                },
                style : ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  )
                ),
                child: const Text(
                  'Update',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32.0),
            const Text(
              'Password Change',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text('Current Password'),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Enter your current password',
                border: UnderlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            const Text('Re-enter New Password'),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Re-enter your new password',
                border: UnderlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24.0),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  // Handle password change action
                },
                style : ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  )
                ),
                child: const Text(
                  'Update',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}