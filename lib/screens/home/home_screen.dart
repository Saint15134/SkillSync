import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// MODELS & SERVICES
import 'package:skillsync/models/conversation_model.dart';
import 'package:skillsync/models/user_model.dart';
import 'package:skillsync/services/database_service.dart';
import 'package:skillsync/providers/user_provider.dart';

// SCREENS & WIDGETS
import 'package:skillsync/screens/chat/chat_screen.dart';
import 'package:skillsync/widgets/bottom_nav.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseService _dbService = DatabaseService();
  
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final authUser = FirebaseAuth.instance.currentUser;
      if (authUser != null) {
        final provider = context.read<UserProvider>();
        await provider.fetchUser(authUser.uid);

        if (provider.needsOnboarding && mounted) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/onboarding_current',
            (route) => false,
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Semantics(
            header: true,
            child: Text(
              'Messages',
              style: TextStyle(
                color: colorScheme.onSurface, // 🟢 Theme Aware
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.8,
              ),
            ),
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        elevation: 4,
        backgroundColor: colorScheme.primary,
        tooltip: "Start a new match",
        // 🟢 FIX: Icon uses onPrimary to contrast with button background
        child: Icon(Icons.add_rounded, color: colorScheme.onPrimary, size: 30),
        onPressed: () => Navigator.pushNamed(context, '/matching'),
      ),

      body: currentUser == null 
        ? Semantics(
            label: "Loading user data",
            child: Center(child: CircularProgressIndicator(color: colorScheme.primary))
          )
        : StreamBuilder<List<ConversationModel>>(
            stream: _dbService.getMyConversations(currentUser.uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Semantics(
                  label: "Loading conversations",
                  child: Center(child: CircularProgressIndicator(color: colorScheme.primary))
                );
              }

              if (snapshot.hasError) {
                return Center(child: Text("Error loading chats: ${snapshot.error}", style: TextStyle(color: colorScheme.onSurface)));
              }

              final conversations = snapshot.data ?? [];

              if (conversations.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ExcludeSemantics(
                        child: Icon(Icons.chat_bubble_outline_rounded, size: 60, color: colorScheme.secondary.withOpacity(0.3)),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "No conversations yet.\nGo match with someone!",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: colorScheme.secondary, fontSize: 16),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 20),
                itemCount: conversations.length,
                itemBuilder: (context, index) {
                  final conv = conversations[index];
                  return _ChatTile(
                    conversation: conv,
                    currentUserId: currentUser.uid,
                  );
                },
              );
            },
          ),

      bottomNavigationBar: AppBottomNav(
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) return;
          final routes = ['/home', '/notifications', '/explore', '/community', '/user_profile'];
          Navigator.pushReplacementNamed(context, routes[index]);
        },
      ),
    );
  }
}

class _ChatTile extends StatelessWidget {
  final ConversationModel conversation;
  final String currentUserId;

  const _ChatTile({required this.conversation, required this.currentUserId});

  @override
  Widget build(BuildContext context) {
    final dbService = DatabaseService();
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return FutureBuilder<UserModel?>(
      future: dbService.getChatPartner(conversation.id, currentUserId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Semantics(
            label: "Loading chat details",
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  color: colorScheme.surface.withOpacity(0.5), // 🟢 Theme Aware
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          );
        }

        final partner = snapshot.data!;
        final String displayName = partner.fullName.trim().isEmpty 
            ? partner.username 
            : partner.fullName;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: MergeSemantics(
            child: Semantics(
              button: true,
              label: "Chat with $displayName",
              hint: "Double tap to open conversation",
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatScreen(
                        chatName: displayName,
                        conversationId: conversation.id,
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: colorScheme.surface, // 🟢 Theme Aware
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(isDark ? 0.2 : 0.03), // 🟢 Dynamic Shadow
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      )
                    ],
                  ),
                  child: Row(
                    children: [
                      ExcludeSemantics(
                        child: CircleAvatar(
                          radius: 28,
                          backgroundColor: theme.scaffoldBackgroundColor, // 🟢 Theme Aware
                          backgroundImage: partner.profilePictureUrl.isNotEmpty 
                              ? NetworkImage(partner.profilePictureUrl) 
                              : null,
                          child: partner.profilePictureUrl.isEmpty 
                              ? Icon(Icons.person_rounded, color: colorScheme.primary) 
                              : null,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              displayName,
                              style: TextStyle(
                                color: colorScheme.onSurface, // 🟢 Theme Aware
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Tap to start chatting",
                              style: TextStyle(
                                color: colorScheme.secondary, // 🟢 Theme Aware
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ExcludeSemantics(
                        child: Icon(Icons.arrow_forward_ios_rounded, 
                            size: 14, 
                            color: colorScheme.secondary.withOpacity(0.5)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}