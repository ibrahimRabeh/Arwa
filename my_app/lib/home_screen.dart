// home_page.dart
import 'package:flutter/material.dart';
import 'bottomNav.dart';
import 'colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final int _currentIndex = 3;

  // List of items for the grid view to make it dynamic
  final List<Map<String, dynamic>> _gridItems = [
    {
      'icon': Icons.person,
      'label': 'المحاسبين',
      'route': '/AccountantsPage',
    },
    {
      'icon': Icons.note_add_outlined,
      'label': 'انشاء طلب',
      'route': '/createOrders',
    },
  ];

  final appBar = AppBar(
    backgroundColor: AppColors().backgroundColors,
    elevation: 0,
    title: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(90.0),
      ),
      child: Center(
        child: TextField(
          decoration: InputDecoration(
            hintText: 'ابحث عن محاسب',
            hintStyle: TextStyle(color: Colors.grey),
            border: InputBorder.none,
            contentPadding:
                EdgeInsets.symmetric(vertical: 6.0, horizontal: 13.0),
          ),
          textAlign: TextAlign.right,
          style: TextStyle(color: Colors.black),
        ),
      ),
    ),
    actions: const [
      SizedBox(width: 48), // Placeholder to balance the leading icon
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().backgroundColors,
      appBar: appBar,
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
              ),
              itemCount: _gridItems.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final item = _gridItems[index];
                return _buildGridItem(
                  item['icon'],
                  item['label'],
                  item['route'],
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(index: _currentIndex),
    );
  }

  Widget _buildGridItem(IconData icon, String label, String route) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(route, arguments: 'HomeScreen');
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors().backgroundColors,
          borderRadius: BorderRadius.circular(25.0),
          border: Border.all(color: Colors.black, width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 80, color: Colors.black),
            const SizedBox(height: 14.0),
            Text(
              label,
              style: const TextStyle(fontSize: 15, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
