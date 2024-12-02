import 'package:flutter/material.dart';
import 'accountantsNav.dart';
import 'colors.dart';

// Accountant's Chat List Page
class accountantsChat extends StatefulWidget {
  const accountantsChat({super.key});

  @override
  _accountantsChatState createState() => _accountantsChatState();
}

class _accountantsChatState extends State<accountantsChat> {
  final int _currentIndex = 2;

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
            _buildListItem(
              'شركة التقنية الحديثة',
              'بخصوص التقارير المالية الشهرية',
              'طلب استشارة محاسبية',
            ),
            _buildListItem(
              'مؤسسة الأمل التجارية',
              'تم إرسال الميزانية المطلوبة',
              'إعداد تقرير مالي',
            ),
            _buildListItem(
              'مجموعة النور',
              'موعد تسليم التدقيق المحاسبي',
              'تدقيق حسابات',
            ),
            _buildListItem(
              'شركة البناء المتحدة',
              'تفاصيل خطة التوفير الضريبي',
              'استشارة ضريبية',
            ),
          ],
        ),
      ),
      bottomNavigationBar: accountantsNav(index: _currentIndex),
    );
  }

  Widget _buildListItem(
      String clientName, String lastMessage, String projectType) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AccountantChatInterface(
              clientName: clientName,
              projectType: projectType,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 13.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColors().backgroundColors,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Colors.black, width: 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.arrow_back_ios_new, color: Colors.black),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    clientName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    projectType,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    lastMessage,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Accountant's Chat Interface
class AccountantChatInterface extends StatefulWidget {
  final String clientName;
  final String projectType;

  const AccountantChatInterface({
    Key? key,
    required this.clientName,
    required this.projectType,
  }) : super(key: key);

  @override
  _AccountantChatInterfaceState createState() =>
      _AccountantChatInterfaceState();
}

class _AccountantChatInterfaceState extends State<AccountantChatInterface> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<Map<String, dynamic>> _messages = [
    {
      'content': 'مرحباً، نحتاج إلى مراجعة التقارير المالية للربع الأخير',
      'isClient': true,
      'timestamp': '10:30 ص'
    },
    {
      'content':
          'أهلاً بكم، هل يمكنكم إرسال كشوفات الحسابات والميزانية العمومية؟',
      'isClient': false,
      'timestamp': '10:32 ص'
    },
    {
      'content': 'نعم، سأقوم بإرسالها خلال ساعة',
      'isClient': true,
      'timestamp': '10:35 ص'
    },
    {
      'content': 'تم إرسال المستندات المطلوبة في المرفقات',
      'isClient': true,
      'timestamp': '11:15 ص'
    },
    {
      'content':
          'شكراً جزيلاً، سأقوم بمراجعتها وإعداد التقرير المطلوب خلال يومين عمل',
      'isClient': false,
      'timestamp': '11:20 ص'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors().backgroundColors.withOpacity(0.8),
        title: Column(
          children: [
            Text(
              widget.clientName,
              style: const TextStyle(color: Colors.black, fontSize: 18),
            ),
            Text(
              widget.projectType,
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: Container(
        color: AppColors().backgroundColors,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(16.0),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  return _buildMessage(
                    message['content'],
                    message['isClient'],
                    message['timestamp'],
                  );
                },
              ),
            ),
            _buildInputBar(),
          ],
        ),
      ),
      bottomNavigationBar: accountantsNav(index: 2),
    );
  }

  Widget _buildMessage(String content, bool isClient, String timestamp) {
    final alignment =
        isClient ? MainAxisAlignment.start : MainAxisAlignment.end;
    final backgroundColor = isClient ? const Color(0xFFE0E0E0) : Colors.black;
    final textColor = isClient ? Colors.black : Colors.white;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment:
            isClient ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: alignment,
            children: [
              Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.75,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 10.0,
                ),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Text(
                  content,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16.0,
                  ),
                  textDirection: TextDirection.rtl,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
            child: Text(
              timestamp,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12.0,
              ),
              textDirection: TextDirection.rtl,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'اكتب رسالتك هنا...',
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 10.0),
              ),
              textDirection: TextDirection.rtl,
              onSubmitted: (value) => _sendMessage(), // Send message on "Enter"
            ),
          ),
          IconButton(
            icon: const Icon(Icons.attach_file, color: Colors.black),
            onPressed: _attachFile, // Mock file sending
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.black),
            onPressed: _sendMessage, // Send message on button press
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    final messageText = _controller.text.trim();
    if (messageText.isNotEmpty) {
      setState(() {
        _messages.add({
          'content': messageText,
          'isClient': false,
          'timestamp': '${DateTime.now().hour}:${DateTime.now().minute}'
        });
        _controller.clear();
      });
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 100,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _attachFile() {
    // Implement file attachment functionality
    setState(() {
      _messages.add({
        'content': 'تم إرسال مرفق: تقرير مراجعة الحسابات.pdf',
        'isClient': false,
        'timestamp': '${DateTime.now().hour}:${DateTime.now().minute}'
      });
    });
  }
}
