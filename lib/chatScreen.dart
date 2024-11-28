import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intl/intl.dart';

import 'message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {


  final TextEditingController _userInput = TextEditingController();
  static const apiKey = "AIzaSyAG6kqc7D4dMzv9TG6xANMN7xQ1SlDJmwE";
  final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);

  final List<Message> _messages = [];
  bool run = false;


  Future<void> sendMessage() async {
    final message = _userInput.text;

    if (message.isEmpty) return;

    setState(() {
      _messages.add(Message(isUser: true, message: message, date: DateTime.now()));
    });

    // Clear the text input field after message is added
    _userInput.clear();

    try {
      final content = [Content.text(message)];
      final response = await model.generateContent(content);

      setState(() {
        _messages.add(Message(
          isUser: false,
          message: response.text ?? "Sorry, I couldn't understand that.",
          date: DateTime.now(),
        ));
      });
    } catch (e) {
      setState(() {
        _messages.add(Message(
          isUser: false,
          message: "Error occurred while processing your request.",
          date: DateTime.now(),
        ));
      });
    }
  }


  final FocusNode _focusNode = FocusNode();

  bool _hasFocus = false;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();

    // Use the provided controller or create an internal one

    // Listen to focus changes
    _focusNode.addListener(() {
      setState(() {
        _hasFocus = _focusNode.hasFocus;
      });
    });

  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return Messages(
                  isUser: message.isUser,
                  message: message.message,
                  date: DateFormat('HH:mm').format(message.date),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: _hasFocus || _hasText ? Colors.white : Colors.white,
                        border: Border.all(
                          color: _hasFocus ? Colors.blueAccent : Colors.white,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(10),

                      ) ,
                      child: TextField(
                        focusNode: _focusNode,
                        controller: _userInput,
                        style: GoogleFonts.beVietnamPro(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          focusColor: Colors.blueAccent,
                          hintText: "Enter the Message",
                          filled: true,
                          fillColor: Colors.black.withOpacity(0.2),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                IconButton(
                  padding: const EdgeInsets.all(12),
                  iconSize: 27,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all( Colors.blueAccent),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all(const CircleBorder()),
                  ),
                  onPressed: () {
                    sendMessage();
                  },
                  icon: const Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
