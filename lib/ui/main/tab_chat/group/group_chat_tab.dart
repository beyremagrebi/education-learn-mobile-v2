import 'package:flutter/material.dart';
import 'package:studiffy/utils/widgets/custum_input_field.dart';

import '../chat_details.dart';
import '../chat_page.dart';
import '../widgets/chat_list_item.dart';

class GroupChatsTab extends StatelessWidget {
  final bool isDarkMode;

  const GroupChatsTab({
    super.key,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    // Mock data for group chats
    final List<ChatPreview> groupChats = [
      ChatPreview(
        id: 'g1',
        name: 'CLASS-TC01 Mathématiques',
        lastMessage: 'Prof: N\'oubliez pas le devoir pour lundi prochain.',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        unreadCount: 3,
        avatar: null,
        isGroup: true,
        memberCount: 28,
      ),
      ChatPreview(
        id: 'g2',
        name: 'Projet de Physique - Groupe 3',
        lastMessage: 'Karim: J\'ai terminé la partie sur les circuits.',
        timestamp: DateTime.now().subtract(const Duration(hours: 5)),
        unreadCount: 0,
        avatar: null,
        isGroup: true,
        memberCount: 5,
      ),
      ChatPreview(
        id: 'g3',
        name: 'Informatique - Entraide',
        lastMessage: 'Sarah: Quelqu\'un peut m\'aider avec le TP de Java?',
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        unreadCount: 12,
        avatar: null,
        isGroup: true,
        memberCount: 32,
      ),
      ChatPreview(
        id: 'g4',
        name: 'Annonces Importantes',
        lastMessage: 'Admin: Les examens finaux commenceront le 15 juin.',
        timestamp: DateTime.now().subtract(const Duration(days: 3)),
        unreadCount: 0,
        avatar: null,
        isGroup: true,
        memberCount: 120,
      ),
    ];

    return Column(
      children: [
        // Search bar
        const CustomInputField(
          hintText: 'Recherche',
          prefixIcon: Icons.search,
        ),

        // Group chat list
        Expanded(
          child: groupChats.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.group_outlined,
                        size: 64,
                        color: isDarkMode
                            ? Colors.grey.shade700
                            : Colors.grey.shade400,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Aucun groupe',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode
                              ? Colors.grey.shade400
                              : Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Créez ou rejoignez un groupe',
                        style: TextStyle(
                          fontSize: 14,
                          color: isDarkMode
                              ? Colors.grey.shade500
                              : Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: groupChats.length,
                  itemBuilder: (context, index) {
                    final chat = groupChats[index];
                    return ChatListItem(
                      chat: chat,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatDetailPage(
                              chatId: chat.id,
                              chatName: chat.name,
                              isGroup: true,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
        ),
      ],
    );
  }
}
