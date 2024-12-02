import 'package:flutter/material.dart';
import 'colors.dart';

class accountantsDetails extends StatefulWidget {
  const accountantsDetails({super.key});

  @override
  State<accountantsDetails> createState() => _accountantsDetailsState();
}

class _accountantsDetailsState extends State<accountantsDetails> {
  final _costController = TextEditingController();
  final _noteController = TextEditingController();

  @override
  void dispose() {
    _costController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> orderDetails =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Additional order details
    final Map<String, String> additionalDetails = {
      'رقم الطلب': '#12345',
      'تاريخ التقديم': '2024/11/27',
      'نوع الخدمة': 'استشارة محاسبية',
      'درجة الأولوية': 'عالية',
    };

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
              _buildStatusCard(screenWidth, screenHeight, orderDetails),
              SizedBox(height: screenHeight * 0.02),

              // Request Details Card
              _buildDetailsCard(
                  screenWidth, screenHeight, orderDetails, additionalDetails),
              SizedBox(height: screenHeight * 0.02),

              // Cost Proposal Section (only shown for new requests)
              if (orderDetails['status'] == 'قيد الدراسة')
                _buildProposalSection(screenWidth, screenHeight),

              // Action Buttons
              _buildActionButtons(screenWidth, screenHeight, orderDetails),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusCard(double screenWidth, double screenHeight,
      Map<String, dynamic> orderDetails) {
    return Container(
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
          const Text(
            'حالة الطلب',
            style: TextStyle(
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
              color: _getStatusColor(orderDetails['status']),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Text(
              orderDetails['status'],
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsCard(
      double screenWidth,
      double screenHeight,
      Map<String, dynamic> orderDetails,
      Map<String, String> additionalDetails) {
    return Container(
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
          const Text(
            'تفاصيل الطلب',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          _buildDetailRow(
              'اسم العميل', orderDetails['businessName'], screenWidth),
          _buildDetailRow('وصف الطلب', orderDetails['request'], screenWidth),
          ...additionalDetails.entries.map(
            (entry) => _buildDetailRow(entry.key, entry.value, screenWidth),
          ),
          if (orderDetails['proposedCost'] != null)
            _buildDetailRow('التكلفة المقترحة',
                '${orderDetails['proposedCost']} ريال', screenWidth),
        ],
      ),
    );
  }

  Widget _buildProposalSection(double screenWidth, double screenHeight) {
    return Container(
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
          const Text(
            'تقديم عرض',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          TextField(
            controller: _costController,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.right,
            decoration: const InputDecoration(
              labelText: 'التكلفة المقترحة (ريال)',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          TextField(
            controller: _noteController,
            maxLines: 3,
            textAlign: TextAlign.right,
            decoration: const InputDecoration(
              labelText: 'ملاحظات إضافية',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(double screenWidth, double screenHeight,
      Map<String, dynamic> orderDetails) {
    if (orderDetails['status'] == 'قيد الدراسة') {
      return Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                // Handle reject
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
              ),
              child: const Text('رفض الطلب'),
            ),
          ),
          SizedBox(width: screenWidth * 0.02),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                // Handle submit proposal
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
              ),
              child: const Text('تقديم العرض'),
            ),
          ),
        ],
      );
    } else {
      return Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                // Handle chat
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.chat_bubble_outline, color: Colors.white),
                  SizedBox(width: 8),
                  Text('محادثة العميل'),
                ],
              ),
            ),
          ),
        ],
      );
    }
  }

  Widget _buildDetailRow(String label, String value, double screenWidth) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
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
