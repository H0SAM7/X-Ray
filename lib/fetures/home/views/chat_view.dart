import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:image_picker/image_picker.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});
static String id='ChatView';

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final List<Map<String, dynamic>> messages = [];
  final TextEditingController _controller = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  void _sendMessage(String text) {
    if (text.isNotEmpty) {
      setState(() {
        messages.add({'text': text, 'sender': 'user'});
      });
      // Simulate a response
      Future.delayed(Duration(milliseconds: 500), () {
        setState(() {
          messages.add({'text': 'This is a response from ChatGPT.', 'sender': 'chatgpt'});
        });
      });
      _controller.clear();
    }
  }

  Future<void> _sendImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        messages.add({
          'image': File(image.path),
          'sender': 'user',
        });
      });
      // Simulate a response
      Future.delayed(Duration(milliseconds: 500), () {
        setState(() {
          messages.add({'text': 'This is a response from ChatGPT.', 'sender': 'chatgpt'});
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('X-Ray Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isUserMessage = message['sender'] == 'user';
                return message['text'] != null
                    ? ChatBubble(
                        alignment: isUserMessage ? Alignment.topRight : Alignment.topLeft,
                        margin: EdgeInsets.only(top: 10),
                        backGroundColor: isUserMessage ? Colors.blue : Colors.grey.shade300,
                        child: Text(
                          message['text']!,
                          style: TextStyle(color: isUserMessage ? Colors.white : Colors.black),
                        ),
                      )
                    : Container(
                        alignment: isUserMessage ? Alignment.topRight : Alignment.topLeft,
                        margin: EdgeInsets.only(top: 10),
                        child: Image.file(
                          message['image'],
                          width: 200, // Adjust the width according to your needs
                        ),
                      );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () => _sendMessage(_controller.text),
                ),
                IconButton(
                  icon: Icon(Icons.image),
                  onPressed: _sendImage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}