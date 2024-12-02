// orders_page.dart
import 'package:flutter/material.dart';
import 'bottomNav.dart';
import 'colors.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  final int _currentIndex = 2;

  // Sample orders data related to the new project
  final List<Map<String, String>> orders = [
    {
      'name': 'John Doe Accounting',
      'request': 'طلب استشارة محاسبية لشركة ناشئة',
      'status': 'قيد الدراسة',
    },
    {
      'name': 'ABC Consultants',
      'request': 'إعداد تقرير مالي شامل',
      'status': 'تمت',
    },
    {
      'name': 'Finance Experts',
      'request': 'تدقيق حسابات الشهر الماضي',
      'status': 'قيد التعديل',
    },
    {
      'name': 'Global Accountants',
      'request': 'إعداد موازنة للسنة القادمة',
      'status': 'نشط',
    },
    {
      'name': 'Premium Advisory',
      'request': 'تقديم خطة توفير ضريبي',
      'status': 'ملغاة',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors().backgroundColors,
      appBar: AppBar(
        backgroundColor: AppColors().backgroundColors,
        elevation: 0,
        title: const Text(
          'الطلبات',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04), // Adaptive padding
        child: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];
            return _buildListItem(
              screenWidth,
              screenHeight,
              order['name']!,
              order['request']!,
              order['status']!,
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavBar(index: _currentIndex),
    );
  }

  Widget _buildListItem(double screenWidth, double screenHeight, String name,
      String request, String status) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed('/details', arguments: {
          'name': name,
          'request': request,
          'status': status,
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
        padding: EdgeInsets.all(screenWidth * 0.03),
        decoration: BoxDecoration(
          color: AppColors().backgroundColors,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Colors.black, width: 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Row(
                children: [
                  const Icon(Icons.arrow_back_ios_new),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.03,
                      vertical: screenHeight * 0.01,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor(status),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Text(
                      status,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.04,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: screenWidth * 0.05,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    request,
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color statusColor(String status) {
    switch (status) {
      case 'تمت':
        return Colors.green;
      case 'قيد الدراسة':
        return Colors.orange;
      case 'قيد التعديل':
        return Colors.blue;
      case 'نشط':
        return Colors.purple;
      case 'ملغاة':
        return Colors.red;
      default:
        return Colors.black;
    }
  }
}
