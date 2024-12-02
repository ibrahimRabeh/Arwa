import 'package:flutter/material.dart';
import 'colors.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, String> orderDetails =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Additional order details that would typically come from your backend
    final Map<String, String> additionalDetails = {
      'رقم الطلب': '#12345',
      'تاريخ التقديم': '2024/11/27',
      'الميزانية المقترحة': '٥٠٠٠ ريال',
      'المدة المتوقعة': '٧ أيام',
      'نوع الخدمة': 'استشارة محاسبية',
      'درجة الأولوية': 'عالية',
    };
    Widget review = Text(
      '',
    );
    if (orderDetails['status'] == 'تمت') {
      review = Expanded(
        child: ElevatedButton(
          onPressed: () {
            // Handle scheduling functionality
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.star, color: Colors.white),
              SizedBox(width: screenWidth * 0.02),
              const Text(
                'تقييم الطلب',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors().backgroundColors,
      appBar: AppBar(
        backgroundColor: AppColors().backgroundColors,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'تفاصيل الطلب',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Status Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(screenWidth * 0.04),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'حالة الطلب',
                      style: TextStyle(
                        fontSize: screenWidth * 0.045,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.03,
                        vertical: screenHeight * 0.01,
                      ),
                      decoration: BoxDecoration(
                        color: _getStatusColor(orderDetails['status']!),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Text(
                        orderDetails['status']!,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.04,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: screenHeight * 0.02),

              // Request Details Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(screenWidth * 0.04),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'تفاصيل الطلب',
                      style: TextStyle(
                        fontSize: screenWidth * 0.045,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    _buildDetailRow(
                        'اسم العميل', orderDetails['name']!, screenWidth),
                    _buildDetailRow(
                        'وصف الطلب', orderDetails['request']!, screenWidth),
                    ...additionalDetails.entries.map(
                      (entry) =>
                          _buildDetailRow(entry.key, entry.value, screenWidth),
                    ),
                  ],
                ),
              ),

              SizedBox(height: screenHeight * 0.02),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle chat functionality
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding:
                            EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.chat_bubble_outline,
                              color: Colors.white),
                          SizedBox(width: screenWidth * 0.02),
                          const Text(
                            'محادثة المحاسب',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  review,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, double screenWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: screenWidth * 0.04),
              textAlign: TextAlign.right,
            ),
          ),
          SizedBox(width: screenWidth * 0.04),
          Text(
            '$label:',
            style: TextStyle(
              fontSize: screenWidth * 0.04,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
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
