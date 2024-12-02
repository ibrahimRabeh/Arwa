import 'package:flutter/material.dart';
import 'accountantsNav.dart';
import 'colors.dart';

class accountantsOrders extends StatefulWidget {
  const accountantsOrders({super.key});

  @override
  _accountantsOrdersState createState() => _accountantsOrdersState();
}

class _accountantsOrdersState extends State<accountantsOrders> {
  final int _currentIndex = 1;

  // Sample orders data for accountants
  final List<Map<String, dynamic>> orders = [
    {
      'businessName': 'شركة التقنية الحديثة',
      'request': 'طلب استشارة محاسبية لشركة ناشئة',
      'status': 'قيد الدراسة',
      'proposedCost': null,
    },
    {
      'businessName': 'مؤسسة الأمل التجارية',
      'request': 'إعداد تقرير مالي شامل',
      'status': 'تم قبول العرض',
      'proposedCost': '4500',
    },
    {
      'businessName': 'مجموعة النور',
      'request': 'تدقيق حسابات الشهر الماضي',
      'status': 'قيد التنفيذ',
      'proposedCost': '3000',
    },
    {
      'businessName': 'شركة البناء المتحدة',
      'request': 'إعداد موازنة للسنة القادمة',
      'status': 'تم الرفض',
      'proposedCost': null,
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
          'الطلبات الواردة',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];
            return _buildListItem(
              screenWidth,
              screenHeight,
              order,
            );
          },
        ),
      ),
      bottomNavigationBar: accountantsNav(index: _currentIndex),
    );
  }

  Widget _buildListItem(
    double screenWidth,
    double screenHeight,
    Map<String, dynamic> order,
  ) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed('/accountantsDetails', arguments: order);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
        padding: EdgeInsets.all(screenWidth * 0.03),
        decoration: BoxDecoration(
          color: AppColors().backgroundColors,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Colors.black, width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.03,
                    vertical: screenHeight * 0.01,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor(order['status']),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Text(
                    order['status'],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.04,
                    ),
                  ),
                ),
                Text(
                  order['businessName'],
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.01),
            Text(
              order['request'],
              style: TextStyle(
                fontSize: screenWidth * 0.04,
              ),
              textAlign: TextAlign.right,
            ),
            if (order['proposedCost'] != null) ...[
              SizedBox(height: screenHeight * 0.01),
              Text(
                'التكلفة المقترحة: ${order['proposedCost']} ريال',
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.right,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color statusColor(String status) {
    switch (status) {
      case 'قيد الدراسة':
        return Colors.orange;
      case 'تم قبول العرض':
        return Colors.green;
      case 'قيد التنفيذ':
        return Colors.blue;
      case 'تم الرفض':
        return Colors.red;
      default:
        return Colors.black;
    }
  }
}
