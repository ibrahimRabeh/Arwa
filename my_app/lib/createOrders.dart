import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'colors.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  String? selectedBillingOption;
  String? selectedBusinessSize;
  bool showEstimatedHours = false;
  int estimatedHours = 0;
  List<String> uploadedFiles = [];
  final TextEditingController descriptionController = TextEditingController();
  void calculateEstimatedHours() {
    // Example logic for hours calculation based on description length
    estimatedHours = descriptionController.text.length ~/ 10; // Example logic
  }

  Future<void> pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
    );
    if (result != null) {
      setState(() {
        uploadedFiles = result.files.map((file) => file.name).toList();
      });
    }
  }

  Widget _buildToggleButton(String label, String value, String? selectedValue,
      VoidCallback onPressed) {
    return Container(
      child: InkWell(
        onTap: onPressed,
        child: Container(
          height: 40.0,
          width: 100,
          decoration: BoxDecoration(
            color: selectedValue == value
                ? AppColors().textColors
                : const Color.fromARGB(255, 210, 209, 209),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: selectedValue == value ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().backgroundColors,
      appBar: AppBar(
        backgroundColor: AppColors().backgroundColors,
        title: const Text(
          'طلب جديد',
          style: TextStyle(fontSize: 35),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Dropdown for service selection
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'اختر الخدمة',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                items: [
                  'تنظيم الفواتير',
                  'الإقرار الضريبي',
                  'إعداد القوائم المالية',
                  'المراجعة على المصروفات والإيرادات',
                ].map((service) {
                  return DropdownMenuItem<String>(
                    value: service,
                    child: Text(service),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {});
                },
              ),
              const SizedBox(height: 16.0),

              // Business Size Selection
              Column(
                children: [
                  const Text(
                    'حجم الشركة',
                    style: TextStyle(fontSize: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildToggleButton(
                            'صغير جدًا', 'صغير جدًا', selectedBusinessSize, () {
                          setState(() => selectedBusinessSize = 'صغير جدًا');
                        }),
                        _buildToggleButton('صغير', 'صغير', selectedBusinessSize,
                            () {
                          setState(() => selectedBusinessSize = 'صغير');
                        }),
                        _buildToggleButton(
                            'متوسط', 'متوسط', selectedBusinessSize, () {
                          setState(() => selectedBusinessSize = 'متوسط');
                        }),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),

              // Description Field
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'وصف الطلب',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                maxLines: 5,
                onChanged: (text) {
                  if (selectedBillingOption == "بالساعة") {
                    setState(() => calculateEstimatedHours());
                  }
                },
              ),
              const SizedBox(height: 16.0),

              // Billing Option Selection
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildToggleButton(
                      'بالساعة', 'بالساعة', selectedBillingOption, () {
                    setState(() {
                      selectedBillingOption = 'بالساعة';
                      showEstimatedHours = true;
                      calculateEstimatedHours();
                    });
                  }),
                  _buildToggleButton('بالعقد', 'بالعقد', selectedBillingOption,
                      () {
                    setState(() {
                      selectedBillingOption = 'بالعقد';
                      showEstimatedHours = false;
                    });
                  }),
                ],
              ),
              const SizedBox(height: 16.0),

              // Show Estimated Hours if "By the Hour" is Selected
              if (selectedBillingOption == 'بالساعة' &&
                  descriptionController.text.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(16.0),
                  color: Colors.grey.shade200,
                  child: Text(
                    'عدد الساعات المقدرة: $estimatedHours',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              const SizedBox(height: 16.0),

              // Attachments Field
              ElevatedButton.icon(
                onPressed: pickFiles,
                icon: const Icon(Icons.attach_file),
                label: const Text('إرفاق ملفات'),
              ),
              if (uploadedFiles.isNotEmpty)
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: uploadedFiles.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(uploadedFiles[index]),
                    );
                  },
                ),
              const SizedBox(height: 16.0),

              // Submit Button
              ElevatedButton(
                onPressed: () {
                  if (descriptionController.text.isEmpty ||
                      selectedBusinessSize == null ||
                      selectedBillingOption == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('الرجاء ملء جميع الحقول'),
                      ),
                    );
                    return;
                  }
                  Navigator.of(context)
                      .pushNamed('/AccountantsPage', arguments: 'CreateOrder');
                  // Submit the form logic
                },
                child: const Text('إرسال الطلب'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
