import 'package:flutter/material.dart';
import 'package:studiffy/core/style/dimensions.dart';

import 'package:studiffy/utils/widgets/custum_input_field.dart';
import 'package:studiffy/utils/widgets/media/api_image_widget.dart';

import '../../../../core/style/themes/app_theme.dart';
import '../chat_details.dart';
import '../chat_page.dart';
import '../widgets/chat_list_item.dart';

class PrivateChatsTab extends StatelessWidget {
  const PrivateChatsTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Mock data for private chats
    final List<ChatPreview> privateChats = [
      ChatPreview(
        id: '1',
        name: 'Ahmed Bensouda',
        lastMessage: 'Bonjour, avez-vous terminé le devoir de mathématiques?',
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
        unreadCount: 2,
        avatar: null,
        isOnline: true,
      ),
      ChatPreview(
        id: '2',
        name: 'Fatima El Ouazzani',
        lastMessage: 'Merci pour votre aide avec le projet de physique.',
        timestamp: DateTime.now().subtract(const Duration(hours: 1)),
        unreadCount: 0,
        avatar: null,
        isOnline: false,
      ),
      ChatPreview(
        id: '3',
        name: 'Karim Tazi',
        lastMessage: 'Les notes du dernier examen sont disponibles.',
        timestamp: DateTime.now().subtract(const Duration(hours: 3)),
        unreadCount: 1,
        avatar: null,
        isOnline: true,
      ),
      ChatPreview(
        id: '4',
        name: 'Sarah Johnson',
        lastMessage: 'Could you send me the English assignment details?',
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        unreadCount: 0,
        avatar: null,
        isOnline: false,
      ),
      ChatPreview(
        id: '5',
        name: 'Mohammed Alami',
        lastMessage: 'La session de laboratoire est reportée à jeudi.',
        timestamp: DateTime.now().subtract(const Duration(days: 2)),
        unreadCount: 0,
        avatar: null,
        isOnline: false,
      ),
    ];

    // Mock data for user contacts
    final List<UserContact> userContacts = [
      UserContact(
        id: '1',
        name: 'Ahmed B.',
        avatar: null,
        isOnline: true,
      ),
      UserContact(
        id: '2',
        name: 'Fatima E.',
        avatar: null,
        isOnline: false,
      ),
      UserContact(
        id: '3',
        name: 'Karim T.',
        avatar: null,
        isOnline: true,
      ),
      UserContact(
        id: '4',
        name: 'Sarah J.',
        avatar: null,
        isOnline: true,
      ),
      UserContact(
        id: '5',
        name: 'Mohammed A.',
        avatar: null,
        isOnline: false,
      ),
      UserContact(
        id: '6',
        name: 'Yasmine K.',
        avatar: null,
        isOnline: true,
      ),
      UserContact(
        id: '7',
        name: 'Omar L.',
        avatar: null,
        isOnline: false,
      ),
      UserContact(
        id: '8',
        name: 'Leila M.',
        avatar: null,
        isOnline: true,
      ),
      UserContact(
        id: '9',
        name: 'Hassan N.',
        avatar: null,
        isOnline: false,
      ),
      UserContact(
        id: '10',
        name: 'Nadia O.',
        avatar: null,
        isOnline: true,
      ),
    ];

    return Column(
      children: [
        const CustomInputField(
          hintText: 'Recherche',
          prefixIcon: Icons.search,
        ),
        Dimensions.heightMedium,
        Container(
          height: 150,
          padding: const EdgeInsets.only(top: 16, bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, bottom: 8),
                child: Text(
                  'Contacts',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: !AppTheme.islight
                        ? Colors.grey.shade300
                        : Colors.grey.shade700,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  itemCount: userContacts.length,
                  itemBuilder: (context, index) {
                    final contact = userContacts[index];
                    return UserContactItem(
                      contact: contact,
                      onTap: () {
                        // Navigate to chat with this user
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatDetailPage(
                              chatId: contact.id,
                              chatName: contact.name,
                              isGroup: false,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),

        // Divider
        Divider(
          height: 1,
          thickness: 1,
          color: !AppTheme.islight
              ? Colors.grey.shade800.withOpacity(0.5)
              : Colors.grey.shade200,
        ),
        Dimensions.heightMedium,
        // Search bar

        // Chat list
        Expanded(
          child: privateChats.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.chat_bubble_outline,
                        size: 64,
                        color: !AppTheme.islight
                            ? Colors.grey.shade700
                            : Colors.grey.shade400,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Aucune conversation',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: !AppTheme.islight
                              ? Colors.grey.shade400
                              : Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Commencez une nouvelle conversation',
                        style: TextStyle(
                          fontSize: 14,
                          color: !AppTheme.islight
                              ? Colors.grey.shade500
                              : Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: privateChats.length,
                  itemBuilder: (context, index) {
                    final chat = privateChats[index];
                    return ChatListItem(
                      chat: chat,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatDetailPage(
                              chatId: chat.id,
                              chatName: chat.name,
                              isGroup: false,
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

class UserContact {
  final String id;
  final String name;
  final String? avatar;
  final bool isOnline;

  UserContact({
    required this.id,
    required this.name,
    this.avatar,
    this.isOnline = false,
  });
}

class UserContactItem extends StatelessWidget {
  final UserContact contact;

  final VoidCallback onTap;

  const UserContactItem({
    super.key,
    required this.contact,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 70,
        margin: const EdgeInsets.symmetric(horizontal: 6),
        child: Column(
          children: [
            // Avatar with online indicator
            Stack(
              children: [
                Center(
                  child: ApiImageWidget(
                    imageFilename: contact.avatar,
                    width: 56,
                    height: 56,
                    isMen: true,
                  ),
                ),
                // Online indicator
                if (contact.isOnline)
                  Positioned(
                    right: 5,
                    bottom: 0,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: !AppTheme.islight
                              ? Colors.grey.shade900
                              : Colors.white,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            Dimensions.heightSmall,
            // Name
            Text(
              contact.name,
              style: TextStyle(
                fontSize: 12,
                color: !AppTheme.islight ? Colors.white : Colors.grey.shade800,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
