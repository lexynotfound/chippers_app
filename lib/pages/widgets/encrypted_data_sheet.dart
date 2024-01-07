import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/widgets/buttons.dart';
import '../../core/widgets/custom_text_field.dart';
import 'decrypt_page.dart';

class EncryptedDataSheet extends StatelessWidget {
  final List<String> encryptedList;
  final List<String> encryptionKeys;
  final void Function(String, String)
      onPressed; // Menambahkan onPressed ke sini

  const EncryptedDataSheet({
    Key? key,
    required this.encryptedList,
    required this.encryptionKeys,
    required this.onPressed, // Mendeklarasikan onPressed di sini
  }) : super(key: key);

  void handleListItemTap(
      BuildContext context, String selectedData, String encryptionKey) {
    if (encryptionKey.isNotEmpty) {
      onPressed(selectedData,
          encryptionKey); // Menggunakan onPressed yang telah dideklarasikan
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return DecryptPage(
              selectedData: selectedData,
              encryptionKey: encryptionKey,
            );
          },
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Kunci enkripsi tidak tersedia'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  void _handleTapOutside(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _handleTapOutside(context),
      child: Container(
        padding: EdgeInsets.only(
          top: 20.0,
          right: 20.0,
          left: 20.0,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const Text(
                  "Encrypted Data",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 40.0),
              ],
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: encryptedList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(
                      encryptedList[index],
                      style: const TextStyle(fontSize: 16),
                    ),
                    onTap: () {
                      if (index < encryptionKeys.length) {
                        handleListItemTap(context, encryptedList[index],
                            encryptionKeys[index]);
                      } else {
                        // Lakukan penanganan jika encryptionKeys tidak memiliki indeks yang sesuai
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('Tidak ada kunci enkripsi yang sesuai'),
                            duration: Duration(seconds: 3),
                          ),
                        );
                      }
                    },

                  );
                },
              ),
            ),
            Button.filled(
              onPressed: () {
                Navigator.pop(context);
              },
              label: 'Tambah Data Enkripsi',
            ),
            const SizedBox(height: 12.0),
          ],
        ),
      ),
    );
  }
}
