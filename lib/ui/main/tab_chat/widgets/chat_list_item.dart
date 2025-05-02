import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:studiffy/utils/widgets/media/api_image_widget.dart';

import '../../../../core/style/themes/app_theme.dart';
import '../chat_page.dart';

class ChatListItem extends StatelessWidget {
  final ChatPreview chat;
  final VoidCallback onTap;

  const ChatListItem({
    super.key,
    required this.chat,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: !AppTheme.islight
            ? (chat.unreadCount > 0
                ? Colors.grey.shade900.withOpacity(0.5)
                : Colors.transparent)
            : (chat.unreadCount > 0
                ? Colors.blue.shade100.withOpacity(0.3)
                : Colors.white),
        borderRadius: BorderRadius.circular(12),
        border: !AppTheme.islight
            ? Border.all(color: Colors.grey.shade800, width: 1)
            : Border.all(color: Colors.grey.shade200, width: 1),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Stack(
          children: [
            // Avatar
            ApiImageWidget(
              imageFilename: chat.avatar,
              width: 56,
              height: 56,
              isMen: true,
              fit: BoxFit.cover,
            ),
            // Online indicator for private chats
            if (!chat.isGroup && chat.isOnline)
              Positioned(
                right: 0,
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
            // Member count for group chats
            if (chat.isGroup && chat.memberCount != null)
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: !AppTheme.islight
                        ? Colors.grey.shade800
                        : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: !AppTheme.islight
                          ? Colors.grey.shade900
                          : Colors.white,
                      width: 1,
                    ),
                  ),
                  child: Text(
                    '${chat.memberCount}',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: !AppTheme.islight
                          ? Colors.grey.shade300
                          : Colors.grey.shade700,
                    ),
                  ),
                ),
              ),
          ],
        ),
        title: Text(
          chat.name,
          style: TextStyle(
            fontWeight:
                chat.unreadCount > 0 ? FontWeight.bold : FontWeight.normal,
            color: !AppTheme.islight ? Colors.white : Colors.grey.shade800,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          chat.lastMessage,
          style: TextStyle(
            color: !AppTheme.islight
                ? (chat.unreadCount > 0
                    ? Colors.grey.shade300
                    : Colors.grey.shade400)
                : (chat.unreadCount > 0
                    ? Colors.grey.shade700
                    : Colors.grey.shade600),
            fontWeight:
                chat.unreadCount > 0 ? FontWeight.w500 : FontWeight.normal,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Timestamp
            Text(
              _formatTimestamp(chat.timestamp),
              style: TextStyle(
                fontSize: 12,
                color: !AppTheme.islight
                    ? Colors.grey.shade500
                    : Colors.grey.shade600,
              ),
            ),
            // Unread count
            if (chat.unreadCount > 0)
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: !AppTheme.islight
                      ? Colors.blue.shade700
                      : Colors.blue.shade600,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  chat.unreadCount.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 0) {
      if (difference.inDays == 1) {
        return 'Hier';
      } else if (difference.inDays < 7) {
        return DateFormat('EEEE').format(timestamp);
      } else {
        return DateFormat('dd/MM/yyyy').format(timestamp);
      }
    } else if (difference.inHours > 0) {
      return 'Il y a ${difference.inHours}h';
    } else if (difference.inMinutes > 0) {
      return 'Il y a ${difference.inMinutes}m';
    } else {
      return 'À l\'instant';
    }
  }
}
