// engineering_offices_page.dart
import 'package:flutter/material.dart';
import 'bottomNav.dart';
import 'colors.dart';

class ProfilePage extends StatefulWidget {
  final String name;
  const ProfilePage({super.key, required this.name});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors().backgroundColors,
        appBar: AppBar(
          backgroundColor: AppColors().backgroundColors,
        ),
        body: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Icon(
                Icons.account_circle_outlined,
                size: 85,
              ),
              const SizedBox(
                height: 13,
              ),
              Text(
                widget.name,
                style: const TextStyle(fontSize: 30),
              ),
              const SizedBox(
                height: 13,
              ),
              Expanded(
                child: ListView(
                  children: [
                    _buildListItem('الحساب', Colors.black, '/home'),
                    _buildListItem('الاعدادات', Colors.black, '/home'),
                    _buildListItem('خيارات الدفع', Colors.black, '/home'),
                    _buildListItem('المساعدة', Colors.black, '/home'),
                    _buildListItem('تسحيل الخروج', Colors.red, '/home'),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavBar(index: _currentIndex));
  }

  Widget _buildToggleButton(String label, bool isSelected) {
    return Expanded(
      child: Container(
        height: 40.0,
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.transparent,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Colors.black),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListItem(String title, Color cols, String address) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(address);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 13.0),
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: AppColors().backgroundColors,
          borderRadius: BorderRadius.circular(60.0),
          border: Border.all(color: Colors.black, width: 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              children: [
                Icon(Icons.arrow_back_ios_new),
              ],
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: cols),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
