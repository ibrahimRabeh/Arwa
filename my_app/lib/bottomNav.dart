import 'package:flutter/material.dart';
import 'colors.dart';

class BottomNavBar extends StatefulWidget {
  final int index;
  const BottomNavBar({super.key, required this.index});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.index;
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
      if (_currentIndex == 3) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/home', (route) => false);
      } else if (_currentIndex == 2) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/order', (route) => false);
      } else if (_currentIndex == 1) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/chat', (route) => false);
      } else if (_currentIndex == 0) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            '/profile', arguments: "ابراهيم الجهني", (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: AppColors().backgroundColors,
      items: [
        BottomNavigationBarItem(
          backgroundColor: AppColors().backgroundColors,
          icon: const Icon(Icons.account_circle_outlined),
          label: 'حسابي',
        ),
        BottomNavigationBarItem(
          backgroundColor: AppColors().backgroundColors,
          icon: const Icon(Icons.message_outlined),
          label: 'المحادثات',
        ),
        BottomNavigationBarItem(
          backgroundColor: AppColors().backgroundColors,
          icon: const Icon(Icons.receipt_outlined),
          label: 'الطلبات',
        ),
        BottomNavigationBarItem(
          backgroundColor: AppColors().backgroundColors,
          icon: const Icon(Icons.home_filled),
          label: 'الرئيسية',
        ),
      ],
      currentIndex: _currentIndex,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black54,
      showUnselectedLabels: true,
      onTap: _onItemTapped,
    );
  }
}
