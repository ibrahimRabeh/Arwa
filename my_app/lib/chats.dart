import 'package:flutter/material.dart';
import 'bottomNav.dart';
import 'colors.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().backgroundColors,
      appBar: AppBar(
        backgroundColor: AppColors().backgroundColors,
        title: const Text(
          'المحادثات',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildListItem('محمد للمحاسبة', 'استفسار عن الخدمات'),
            _buildListItem('التميز للاستشارات', 'تم استلام الطلب'),
            _buildListItem('أرقام للإدارة', 'استفسار عن تقارير الشركة'),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(index: _currentIndex),
    );
  }

  Widget _buildListItem(String title, String lastMessage) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed('/chatInterface', arguments: title);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 13.0),
        padding: const EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          color: AppColors().backgroundColors,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Colors.black, width: 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.arrow_back_ios_new, color: Colors.black),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 3.0),
                Text(
                  lastMessage,
                  style: const TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
