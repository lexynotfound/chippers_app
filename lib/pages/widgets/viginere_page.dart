import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/widgets/custom_text_field.dart';
import 'decrypt_page.dart';
import 'encrypted_data_sheet.dart';

class VigenereEncryptPage extends StatefulWidget {
  const VigenereEncryptPage({Key? key}) : super(key: key);

  @override
  _VigenereEncryptPageState createState() => _VigenereEncryptPageState();
}

class _VigenereEncryptPageState extends State<VigenereEncryptPage> {
  final TextEditingController plainTextController = TextEditingController();
  final TextEditingController keyController = TextEditingController();
  List<String> encryptedList = [];
  List<String> encryptionKeys = [];

  Future<void> saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('encryptedData', encryptedList);
  }

  Future<void> saveKey(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    encryptionKeys.add(key);
    await prefs.setStringList('encryptionKeys', encryptionKeys);
  }

  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? encryptedData = prefs.getStringList('encryptedData');
    if (encryptedData != null) {
      setState(() {
        encryptedList = encryptedData;
      });
    }
    List<String>? keys = prefs.getStringList('encryptionKeys');
    if (keys != null) {
      setState(() {
        encryptionKeys = keys;
      });
    }
  }

  String encryptVigenere(String plainText, String key) {
    String encryptedText = '';
    int keyIndex = 0;

    for (int i = 0; i < plainText.length; i++) {
      int plainTextChar = plainText.codeUnitAt(i);
      int keyChar = key.codeUnitAt(keyIndex);
      int encryptedChar = (plainTextChar + keyChar) % 26 + 'A'.codeUnitAt(0);

      encryptedText += String.fromCharCode(encryptedChar);

      keyIndex = (keyIndex + 1) % key.length;
    }

    return encryptedText;
  }

  void encryptText() {
    String plainText = plainTextController.text.toUpperCase();
    String key = keyController.text.toUpperCase();

    String encryptedResult = encryptVigenere(plainText, key);

    setState(() {
      encryptedList.add('Hasil Enkripsi: $encryptedResult');
    });

    saveKey(key);
    saveData();
  }

  void _handleTapOutside(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  void handleListItemTap(
      BuildContext context, String selectedData, String encryptionKey) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DecryptPage(
          selectedData: selectedData,
          encryptionKey: encryptionKey,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  void dispose() {
    plainTextController.dispose();
    keyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _handleTapOutside(context);
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Vigenere Encrypt')),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextField(
                controller: plainTextController,
                label: 'Plain Text',
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: keyController,
                label: 'Key',
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: encryptText,
                child: const Text('Encrypt'),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: encryptedList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return EncryptedDataSheet(
                                encryptedList: encryptedList,
                                encryptionKeys:
                                    encryptionKeys, // Tambahkan encryptionKeys di sini
                                onPressed: (selectedData, encryptionKey) {
                                  handleListItemTap(
                                      context, selectedData, encryptionKey);
                                },
                              );
                            },
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: const Color(0xff686BFF),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Column(
                            children: [
                              Text(
                                encryptedList[index],
                                style: const TextStyle(color: Colors.white),
                              ),
                              Text(
                                'Key: ${encryptionKeys.length > index ? encryptionKeys[index] : ""}',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
