import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submit/themes/darkmode.dart';
import 'package:submit/themes/theme_provider.dart';
import '../themes/lightmode.dart';
import 'package:submit/comp/app_bar.dart';
import '../comp/app_drawer.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Directionality(
        textDirection: TextDirection.rtl, // Apply RTL direction
        child: ChatBotApp(),
      ),
    ),
  );
}

class ChatBotApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return MaterialApp(
          title: 'Flutter Chatbot',
          theme: themeProvider.isDarkMode ? darkTheme : lightTheme,
          debugShowCheckedModeBanner: false,
          home: ChatScreen(),
          builder: (context, child) {
            return Directionality(
              textDirection: TextDirection.rtl, // Set full app to RTL
              child: child!,
            );
          },
        );
      },
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  final ScrollController _scrollController = ScrollController();

  void _sendMessage(String text) {
    setState(() {
      _messages.add({'sender': 'user', 'text': text});
    });

    _controller.clear();

    // Auto-scroll to the latest message
    Future.delayed(Duration(milliseconds: 100), () {
      _scrollToBottom();
    });

    // Simulate chatbot response after a short delay
    Future.delayed(Duration(seconds: 1), () {
      _botResponse(text);
    });
  }

  void _botResponse(String lastUserMessage) {
    setState(() {
      _messages
          .add({'sender': 'bot', 'text': 'أنا سمعتك تقول: $lastUserMessage'});
    });

    // Auto-scroll to the latest message
    Future.delayed(Duration(milliseconds: 100), () {
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      endDrawer: AppDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Chatbot', // Big bold title
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController, // Attach scroll controller
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ListTile(
                  title: Align(
                    alignment: message['sender'] == 'user'
                        ? Alignment.centerRight // User messages on right (RTL)
                        : Alignment.centerLeft, // Bot messages on left
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: message['sender'] == 'user'
                            ? Colors.blueAccent
                            : Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        message['text']!,
                        style: TextStyle(
                          color: message['sender'] == 'user'
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
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
                    textDirection: TextDirection.rtl, // Text input RTL
                    decoration: InputDecoration(
                      hintText: 'اكتب رسالتك...', // Arabic placeholder
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      _sendMessage(_controller.text);
                    }
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
