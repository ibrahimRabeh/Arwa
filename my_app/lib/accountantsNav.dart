import 'package:flutter/material.dart';
import 'colors.dart';

class accountantsNav extends StatefulWidget {
  final int index;
  const accountantsNav({super.key, required this.index});

  @override
  _accountantsNavState createState() => _accountantsNavState();
}

class _accountantsNavState extends State<accountantsNav> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.index;
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
      if (_currentIndex == 2) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/accountantsChat', (route) => false);
      } else if (_currentIndex == 1) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/accountantsOrders', (route) => false);
      } else if (_currentIndex == 0) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            '/Accountantprofile', arguments: "محمد الشهري", (route) => false);
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
          icon: const Icon(Icons.receipt_outlined),
          label: 'الطلبات',
        ),
        BottomNavigationBarItem(
          backgroundColor: AppColors().backgroundColors,
          icon: const Icon(Icons.message_outlined),
          label: 'المحادثات',
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
