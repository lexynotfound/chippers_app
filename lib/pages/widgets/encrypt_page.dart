import 'package:chipers_app/pages/widgets/viginere_page.dart';
import 'package:flutter/material.dart';
import 'package:chipers_app/pages/widgets/dashboard_page.dart';
import 'package:chipers_app/pages/widgets/decrypt_page.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/icons.dart';

class EncryptPage extends StatefulWidget {
  const EncryptPage({super.key});

  @override
  State<EncryptPage> createState() => _EncryptPageState();
}

class _EncryptPageState extends State<EncryptPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    DashboardPage(),
    VigenereEncryptPage(),
    DecryptPage(selectedData: '', encryptionKey: '',),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: ColorName.primary,
          onTap: _onItemTapped,
          showSelectedLabels: true, // Menampilkan label saat dipilih
          showUnselectedLabels: true, // Menampilkan label saat tidak dipilih
          items: const [
            BottomNavigationBarItem(
              icon: ImageIcon(IconName.home),
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(IconName.chart),
              label: 'Jadwal',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(IconName.profile),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}

