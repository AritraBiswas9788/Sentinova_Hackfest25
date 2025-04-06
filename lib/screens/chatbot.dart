// lib/controllers/gemini_controller.dart
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sentinova/components/grid_background.dart';

class GeminiController extends GetxController {
  final String _apiKey = 'AIzaSyA1Ei4RtnPc5ZzInKUd8R2kKM1bL_FEQe4';
  final String _geminiUrl =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=';

  var messages = <Map<String, String>>[].obs;
  var isLoading = false.obs;

  Future<void> sendMessage(String userMessage) async {
    if (userMessage.trim().isEmpty) return;

    messages.add({
      'role': 'user',
      'text': userMessage,
      'time': DateTime.now().toIso8601String(),
    });

    isLoading.value = true;

    final response = await _callGeminiAPI(userMessage);

    messages.add({
      'role': 'bot',
      'text': response,
      'time': DateTime.now().toIso8601String(),
    });

    isLoading.value = false;
  }

  Future<String> _callGeminiAPI(String prompt) async {
    try {
      final url = Uri.parse('$_geminiUrl$_apiKey');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'contents': [
            {'parts': [{'text': prompt}]}
          ]
        }),
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        return decoded['candidates'][0]['content']['parts'][0]['text'] ?? 'No response';
      } else {
        return 'Error: ${response.body}';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }
}

// lib/pages/chat_page.dart

class GeminiChatPage extends StatelessWidget {
  final GeminiController controller = Get.find();
  final TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  void _handleSend() {
    final text = textController.text.trim();
    if (text.isNotEmpty) {
      controller.sendMessage(text);
      textController.clear();
      Future.delayed(Duration(milliseconds: 300), () {
        _scrollToBottom();
      });
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent + 100,
        duration: Duration(milliseconds: 400),
        curve: Curves.easeOut,
      );
    });
  }

  Widget _buildBubble(String text, bool isUser, String time) {
    final textColor = isUser ? Colors.white : Colors.white70;
    final timeStr = DateFormat.Hm().format(DateTime.parse(time));

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        padding: EdgeInsets.all(12),
        constraints: BoxConstraints(maxWidth: 280),
        decoration: BoxDecoration(
          gradient: isUser
              ? LinearGradient(
            colors: [Colors.deepPurpleAccent, Colors.purpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
              : null,
          color: isUser ? null : Colors.grey.shade800,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
            bottomLeft: isUser ? Radius.circular(16) : Radius.circular(0),
            bottomRight: isUser ? Radius.circular(0) : Radius.circular(16),
          ),
        ),
        child: Column(
          crossAxisAlignment:
          isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 4),
            Text(
              timeStr,
              style: TextStyle(fontSize: 10, color: Colors.white38),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingBubble() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        padding: EdgeInsets.all(12),
        constraints: BoxConstraints(maxWidth: 200),
        decoration: BoxDecoration(
          color: Colors.grey.shade800,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
            ),
            SizedBox(width: 8),
            Text("Typing...", style: TextStyle(color: Colors.white70))
          ],
        ),
      ),
    );
  }

  Widget _buildChatInput() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(24),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: textController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Message...",
                    hintStyle: TextStyle(color: Colors.white54),
                    border: InputBorder.none,
                  ),
                  onSubmitted: (_) => _handleSend(),
                ),
              ),
              GestureDetector(
                onTap: _handleSend,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Icon(Icons.send, color: Colors.deepPurpleAccent),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Row(
            children: [
              Image.asset("assets/chatbot.png", height: 35, width: 35),
              SizedBox(width: 7),
              Text("Gemini Chat", style: TextStyle(color: Colors.white)),
            ],
          ),
          elevation: 0,
        ),
        body: GridBackground(
            child: Column(
              children: [
                Expanded(
                  child: Obx(() {
                    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
                    return ListView.builder(
                      controller: scrollController,
                      itemCount: controller.messages.length + (controller.isLoading.value ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == controller.messages.length && controller.isLoading.value) {
                          return _buildLoadingBubble();
                        }
                        final msg = controller.messages[index];
                        return _buildBubble(
                          msg['text'] ?? '',
                          msg['role'] == 'user',
                          msg['time'] ?? DateTime.now().toIso8601String(),
                        );
                      },
                    );
                  }),
                ),
                _buildChatInput(),
              ],
            ),
),
);
}
}