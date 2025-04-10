import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FinbuddyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: IntroPage(),
    );
  }
}

class IntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Meet Finbuddy, your Personal AI Finance Assistant",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChatbotPage()),
                  );
                },
                child: Text("Get Started"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChatbotPage extends StatefulWidget {
  @override
  _ChatbotPageState createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final TextEditingController _controller = TextEditingController();
  List<String> chatMessages = [];
  bool _isFirstResponse = true;
  final String selectedModel = "gemini-1.5-flash";
  final String apiKey = dotenv.env['API_KEY'] ?? '';

  Future<void> getResponse(String userMessage) async {
    if (!mounted) return;
    final url =
        "https://generativelanguage.googleapis.com/v1/models/$selectedModel:generateContent?key=$apiKey";

    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "contents": [
          {
            "parts": [
              {"text": userMessage}
            ]
          }
        ]
      }),
    );
    if (!mounted) return;

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      String finbuddyReply = data['candidates']?[0]?['content']?['parts']?[0]
              ?['text'] ??
          "No reply found";

      if (_isFirstResponse &&
          (finbuddyReply.toLowerCase().contains("understood") ||
              finbuddyReply.toLowerCase().contains("i'm ready") ||
              finbuddyReply.toLowerCase().contains("will do"))) {
        _isFirstResponse = false;
      } else {
        setState(() {
          chatMessages.add("Finbuddy: \n " + finbuddyReply);
          _isFirstResponse = false;
        });
      }
    } else {
      setState(() {
        chatMessages
            .add("Finbuddy: Sorry I couldn't process your request right now.");
      });
    }
  }

  @override
  void initState() {
    super.initState();
    String initialPrompt =
        "You are an AI finance assistant named Finbuddy.(give short greeting) Your purpose is to help with questions specifically related to finance and investing. Please explain concepts and provide information in simple, easy-to-understand language. Do not answer questions that are outside the topics of finance and investing.";
    getResponse(initialPrompt);
  }

  Widget buildChatBubble(String message) {
    bool isUser = message.startsWith("You:");
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      decoration: BoxDecoration(
        color: isUser ? Colors.grey[300] : Colors.purple[400],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
          bottomLeft: isUser ? Radius.circular(16) : Radius.circular(0),
          bottomRight: isUser ? Radius.circular(0) : Radius.circular(16),
        ),
      ),
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Text(
        message,
        style: TextStyle(
            fontSize: 16, color: isUser ? Colors.black : Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Finbuddy Chatbot")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: chatMessages.length,
              itemBuilder: (context, index) {
                return buildChatBubble(chatMessages[index]);
              },
            ),
          ),
          Divider(height: 1),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration.collapsed(
                        hintText: "Type a message..."),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.purple),
                  onPressed: () {
                    String message = _controller.text;
                    if (message.trim().isEmpty) return;
                    setState(() {
                      chatMessages.add("You: $message");
                    });
                    getResponse(message);
                    _controller.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
