import 'package:flutter/material.dart';
import 'package:chipers_app/pages/widgets/viginere_page.dart';
import 'package:chipers_app/pages/widgets/decrypt_page.dart';
import '../../core/widgets/menu_card.dart';
import '../../core/widgets/search_input.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/images.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Perkuliahan",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: ColorName.primary,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                /* Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                return const AbsensiPage();
              })); */
              },
              icon: const Icon(
                Icons.qr_code_scanner,
                color: ColorName.primary,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications,
                color: ColorName.primary,
              ),
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            const SizedBox(height: 10.0),
            SearchInput(
              controller: searchController,
            ),
            const SizedBox(height: 40.0),
            MenuCard(
              label: 'Encrypt\nPage',
              backgroundColor: const Color(0xff686BFF),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const VigenereEncryptPage();
                }));
              },
              imagePath: Images.khs,
            ),
            const SizedBox(height: 40.0),
            MenuCard(
              label: 'Decrypt\nPage',
              backgroundColor: const Color(0xffFFB023),
              onPressed: () {
                String selectedData = ' ';
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return DecryptPage(selectedData: selectedData, encryptionKey: '',);
                }));
              },

              imagePath: Images.nMatkul,
            ),
            const SizedBox(height: 40.0),
          ],
        ),
      ),
    );
  }
}
