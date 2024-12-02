// selection_page.dart
import 'package:flutter/material.dart';
import 'colors.dart'; // Replace with your actual color utility file.

class SelectionPage extends StatelessWidget {
  const SelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().backgroundColors,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildOption(
              context,
              icon: Icons.business_center,
              label: 'Business',
              onTap: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/home', (route) => false);
              },
            ),
            const SizedBox(height: 40.0),
            _buildOption(
              context,
              icon: Icons.account_balance_wallet,
              label: 'Accountants',
              onTap: () {
                // Navigate to Accountant Page or perform another action
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/accountantsOrders', (route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(BuildContext context,
      {required IconData icon,
      required String label,
      required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 250,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 60, color: Colors.black),
            const SizedBox(height: 14.0),
            Text(
              label,
              style: const TextStyle(fontSize: 20, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
