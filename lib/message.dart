import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class Message {
  final bool isUser;
  final String message;
  final DateTime date;

  Message({required this.isUser, required this.message, required this.date});
}

class Messages extends StatelessWidget {
  final bool isUser;
  final String message;
  final String date;

  const Messages({
    super.key,
    required this.isUser,
    required this.message,
    required this.date,
  });


  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,

      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        padding: const EdgeInsets.all(9),
        margin: EdgeInsets.symmetric(vertical: 8).copyWith(
          left: isUser ? 80 : 10,
          right: isUser ? 10 : 80,
        ),
        decoration: BoxDecoration(
          color: isUser ? Colors.blueAccent : Colors.grey.shade400,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          message,
          style: GoogleFonts.beVietnamPro(fontSize: 14, fontWeight: FontWeight.w400,color: isUser ? Colors.white : Colors.black.withOpacity(.9),
          )
        ),
      ),
    );
  }
}