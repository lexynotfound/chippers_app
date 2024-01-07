// DecryptPage
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DecryptPage extends StatefulWidget {
  final String selectedData;
  final String encryptionKey;

  const DecryptPage({
    Key? key,
    required this.selectedData,
    required this.encryptionKey,
  }) : super(key: key);

  @override
  State<DecryptPage> createState() => _DecryptPageState();
}

class _DecryptPageState extends State<DecryptPage> {
  String decryptedText = '';

  Future<void> saveDecryptedData(String decryptedData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> decryptedList = prefs.getStringList('decryptedData') ?? [];
    decryptedList.add(decryptedData);
    await prefs.setStringList('decryptedData', decryptedList);
  }

  String decryptVigenere(String encryptedText, String key) {
    String decryptedText = '';
    int keyIndex = 0;

    for (int i = 0; i < encryptedText.length; i++) {
      int encryptedChar = encryptedText.codeUnitAt(i);
      int keyChar = key.codeUnitAt(keyIndex);
      int decryptedChar = (encryptedChar - keyChar) % 26 + 'A'.codeUnitAt(0);

      decryptedText += String.fromCharCode(decryptedChar);

      keyIndex = (keyIndex + 1) % key.length;
    }

    return decryptedText;
  }

  void decryptText() {
    String key = widget.encryptionKey;
    if (widget.selectedData.isNotEmpty && key.isNotEmpty) {
      decryptedText = decryptVigenere(widget.selectedData, key);
      saveDecryptedData(decryptedText);
      setState(() {});
    } else {
      // Handle jika data enkripsi atau kunci kosong
      // Tambahkan logika notifikasi atau pesan kesalahan di sini
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Decrypt Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.selectedData),
            ElevatedButton(
              onPressed: decryptText,
              child: const Text('Decrypt'),
            ),
            const SizedBox(height: 20),
            Text(decryptedText),
          ],
        ),
      ),
    );
  }
}
