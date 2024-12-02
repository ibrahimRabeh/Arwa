import 'package:flutter/material.dart';
import 'colors.dart';

class AccountantsPage extends StatelessWidget {
  final List<Map<String, dynamic>> accountants = [
    {
      'name': 'محمد الشهري',
      'rating': 4.8,
      'email': 'mohammad@gmail.com',
      'phone': '0501234567',
      'description': 'محاسب قانوني معتمد،\n'
          'حاصل على شهادة المحاسب القانوني المعتمد\n'
          'خبرة عشر سنوات في إعداد التقارير المالية وتحليل البيانات.',
      'CostPerHour': '250',
    },
    {
      'name': 'سارة أحمد',
      'rating': 4.7,
      'email': 'sara@gmail.com',
      'phone': '0557654321',
      'description':
          'خبيرة في المحاسبة الإدارية، حاصلة على شهادة محاسب إداري معتمد من معهد المحاسبين الإداريين، وخبرة واسعة في تقديم الاستشارات للشركات.',
      'CostPerHour': '120',
    },
    {
      'name': 'عبد الله صالح',
      'rating': 4.6,
      'email': 'abdullah@gmail.com',
      'phone': '0549876543',
      'description':
          'محاسب متخصص في الضرائب، حاصل على شهادة ماجستير من جامعة اوكسفرد ولدي خبرة ثماني سنوات في إعداد الحسابات الضريبية.',
      'CostPerHour': '150',
    },
    {
      'name': 'ريم فهد',
      'rating': 4.9,
      'email': 'reem@gmail.com',
      'phone': '0562345678',
      'description':
          'محاسبة ومدققة معتمدة، حاصلة على ACCA من المملكة المتحدة، وتعمل في مجال التدقيق المالي منذ 12 عامًا.',
      'CostPerHour': '200',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final String source =
        ModalRoute.of(context)!.settings.arguments as String? ?? 'HomeScreen';

    return Scaffold(
      backgroundColor: AppColors().backgroundColors,
      appBar: AppBar(
        title: const Text("المحاسبون", style: TextStyle(color: Colors.black87)),
        backgroundColor: AppColors().backgroundColors,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: accountants.length,
        itemBuilder: (context, index) {
          final accountant = accountants[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    accountant['name'],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    "التقييم: ${accountant['rating']}",
                    style: TextStyle(
                      color: Colors.orange[600],
                      fontSize: 16,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        accountant['email'],
                        style: const TextStyle(color: Colors.black54),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        accountant['phone'],
                        style: const TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    accountant['description'],
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    "التكلفة للساعة: ${accountant['CostPerHour'] ?? 'غير محدد'} ريال",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/chatInterface',
                                arguments: accountant['name']);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black87,
                          ),
                          child: const Text(
                            "الدردشة",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (source == 'CreateOrder') {
                              // Show success message
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text("تم إرسال الطلب"),
                                  content: const Text(
                                      "تم إرسال طلبك. الرجاء الانتظار للحصول على موافقة المحاسب."),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("حسنًا"),
                                    ),
                                  ],
                                ),
                              );
                            } else if (source == 'HomeScreen') {
                              // Navigate to create order page
                              Navigator.of(context).pushNamed('/createOrders');
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black87,
                          ),
                          child: const Text(
                            "حجز",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
