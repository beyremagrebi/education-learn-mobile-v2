import 'package:flutter/material.dart';

import 'package:studiffy/core/constant/assets.dart';
import 'package:studiffy/core/style/dimensions.dart';
import 'package:studiffy/utils/widgets/background_image_safe_area.dart';

import 'group/group_chat_tab.dart';
import 'private/private_chat_tab.dart';

class ChatPage extends StatelessWidget {
  final bool isDarkMode;

  const ChatPage({
    super.key,
    this.isDarkMode = true,
  });

  @override
  Widget build(BuildContext context) {
    return BackgroundImageSafeArea(
      svgAsset: Assets.bgMain,
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(text: 'Privé'),
                Tab(text: 'Groupe'),
              ],
            ),
            Expanded(
              child: Padding(
                padding: Dimensions.paddingMedium,
                child: TabBarView(
                  children: [
                    // Private chats tab
                    // ignore: prefer_const_constructors
                    PrivateChatsTab(),

                    // Group chats tab
                    GroupChatsTab(isDarkMode: isDarkMode),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatPreview {
  final String id;
  final String name;
  final String lastMessage;
  final DateTime timestamp;
  final int unreadCount;
  final String? avatar;
  final bool isOnline;
  final bool isGroup;
  final int? memberCount;

  ChatPreview({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.timestamp,
    required this.unreadCount,
    this.avatar,
    this.isOnline = false,
    this.isGroup = false,
    this.memberCount,
  });
}

class ChatMessage {
  final String id;
  final String senderId;
  final String senderName;
  final String content;
  final DateTime timestamp;
  final bool isMe;
  final MessageType messageType;

  ChatMessage({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.content,
    required this.timestamp,
    required this.isMe,
    this.messageType = MessageType.text,
  });
}

enum MessageType {
  text,
  image,
  file,
  audio,
  video,
  location,
}
