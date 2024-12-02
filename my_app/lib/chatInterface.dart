import 'package:flutter/material.dart';
import 'bottomNav.dart';
import 'colors.dart';

class ChatInterface extends StatefulWidget {
  final String title;

  const ChatInterface({Key? key, required this.title}) : super(key: key);

  @override
  _ChatInterfaceState createState() => _ChatInterfaceState();
}

class _ChatInterfaceState extends State<ChatInterface> {
  final int _currentIndex = 1;
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, dynamic>> _messages = [
    {
      'content': 'مرحبًا، نحن بحاجة إلى تقرير مالي للشركة.',
      'isUser': true,
      'timestamp': '10:30 ص'
    },
    {
      'content': 'مرحبًا، بالطبع! هل يمكنكم إرسال المستندات اللازمة؟',
      'isUser': false,
      'timestamp': '10:31 ص'
    },
    {
      'content': 'تم إرسال الميزانية السنوية والفواتير.',
      'isUser': true,
      'timestamp': '10:52 ص'
    },
    {
      'content': 'شكراً، سأبدأ بمراجعتها وسأعود إليكم بالتقرير قريباً.',
      'isUser': false,
      'timestamp': '11:23 ص'
    },
  ];

  @override // Added missing override annotation
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors().backgroundColors.withOpacity(0.8),
        title: Column(
          children: [
            Text(
              widget.title,
              style: const TextStyle(color: Colors.black, fontSize: 18),
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
                    message['isUser'], // Changed from isClient to isUser
                    message['timestamp'],
                  );
                },
              ),
            ),
            _buildInputBar(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(index: _currentIndex),
    );
  }

  Widget _buildMessage(String content, bool isUser, String timestamp) {
    final alignment = isUser ? MainAxisAlignment.start : MainAxisAlignment.end;
    final backgroundColor = isUser ? const Color(0xFFE0E0E0) : Colors.black;
    final textColor = isUser ? Colors.black : Colors.white;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment:
            isUser ? CrossAxisAlignment.start : CrossAxisAlignment.end,
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
      padding: const EdgeInsets.all(7.0),
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
          IconButton(
            icon: const Icon(Icons.send, color: Colors.black),
            onPressed: _sendMessage,
          ),
          IconButton(
            icon: const Icon(Icons.attach_file, color: Colors.black),
            onPressed: _attachFile,
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'اكتب رسالتك هنا...',
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
              ),
              textDirection: TextDirection.rtl,
              onSubmitted: (value) => _sendMessage(),
            ),
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
          'isUser': false,
          'timestamp': '${DateTime.now().hour}:${DateTime.now().minute} ص'
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
    setState(() {
      _messages.add({
        'content': 'تم إرسال مرفق: تقرير مراجعة الحسابات.pdf',
        'isUser': false,
        'timestamp': '${DateTime.now().hour}:${DateTime.now().minute} ص'
      });
    });
  }
}
