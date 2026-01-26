import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  final String chatName; // required chat name

  const ChatScreen({super.key, required this.chatName});

  @override
  Widget build(BuildContext context) {
    // Fake messages
    final List<Map<String, String>> messages = const [
      {'sender': 'me', 'text': 'Hey there! How’s it going?'},
      {'sender': 'them', 'text': 'Hi! All good. You?'},
      {'sender': 'me', 'text': 'Pretty good, working on a project.'},
      {'sender': 'them', 'text': 'Nice! Need any help?'},
      {'sender': 'me', 'text': 'Maybe later, thanks!'},
    ];

    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        title: Text(chatName),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          // Chat messages
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                final isMe = msg['sender'] == 'me';
                return Align(
                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(12),
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                    decoration: BoxDecoration(
                      color: isMe ? Colors.deepPurple : Colors.white12,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      msg['text']!,
                      style: TextStyle(
                        color: isMe ? Colors.white : Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Message input (fake, no functionality)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            color: Colors.grey.shade800,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      hintStyle: TextStyle(color: Colors.white54),
                      filled: true,
                      fillColor: Colors.grey.shade700,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.deepPurple,
                  child: const Icon(Icons.send, color: Colors.white, size: 20),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
