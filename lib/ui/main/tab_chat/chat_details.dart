import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:studiffy/core/constant/assets.dart';
import 'package:studiffy/utils/widgets/background_image_safe_area.dart';

import '../../../core/style/themes/app_theme.dart';
import 'chat_page.dart';
import 'widgets/message_bubble.dart';

class ChatDetailPage extends StatefulWidget {
  final String chatId;
  final String chatName;
  final bool isGroup;

  const ChatDetailPage({
    super.key,
    required this.chatId,
    required this.chatName,
    required this.isGroup,
  });

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  bool _isAttachmentMenuOpen = false;

  @override
  void initState() {
    super.initState();
    // Load mock messages
    _loadMessages();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _loadMessages() {
    // Mock data for messages
    final List<ChatMessage> mockMessages = [
      ChatMessage(
        id: '1',
        senderId: 'user1',
        senderName: widget.isGroup ? 'Ahmed Bensouda' : '',
        content: 'Bonjour à tous!',
        timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
        isMe: false,
        messageType: MessageType.text,
      ),
      ChatMessage(
        id: '2',
        senderId: 'currentUser',
        senderName: '',
        content: 'Bonjour! Comment allez-vous?',
        timestamp: DateTime.now()
            .subtract(const Duration(days: 1, hours: 1, minutes: 45)),
        isMe: true,
        messageType: MessageType.text,
      ),
      ChatMessage(
        id: '3',
        senderId: 'user2',
        senderName: widget.isGroup ? 'Fatima El Ouazzani' : '',
        content:
            'Très bien, merci! Quelqu\'un a-t-il commencé le devoir de mathématiques?',
        timestamp: DateTime.now()
            .subtract(const Duration(days: 1, hours: 1, minutes: 30)),
        isMe: false,
        messageType: MessageType.text,
      ),
      ChatMessage(
        id: '4',
        senderId: 'currentUser',
        senderName: '',
        content:
            'Oui, j\'ai déjà fait les exercices 1 à 3. Je peux partager mes notes si vous voulez.',
        timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 1)),
        isMe: true,
        messageType: MessageType.text,
      ),
      ChatMessage(
        id: '5',
        senderId: 'user3',
        senderName: widget.isGroup ? 'Karim Tazi' : '',
        content: 'Ce serait très utile, merci!',
        timestamp:
            DateTime.now().subtract(const Duration(days: 1, minutes: 45)),
        isMe: false,
        messageType: MessageType.text,
      ),
      ChatMessage(
        id: '6',
        senderId: 'currentUser',
        senderName: '',
        content: 'https://example.com/image.jpg',
        timestamp: DateTime.now().subtract(const Duration(hours: 5)),
        isMe: true,
        messageType: MessageType.image,
      ),
      ChatMessage(
        id: '7',
        senderId: 'user1',
        senderName: widget.isGroup ? 'Ahmed Bensouda' : '',
        content: 'Merci beaucoup pour les notes!',
        timestamp: DateTime.now().subtract(const Duration(hours: 4)),
        isMe: false,
        messageType: MessageType.text,
      ),
      ChatMessage(
        id: '8',
        senderId: 'user2',
        senderName: widget.isGroup ? 'Fatima El Ouazzani' : '',
        content:
            'N\'oubliez pas que nous avons un examen la semaine prochaine.',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        isMe: false,
        messageType: MessageType.text,
      ),
      ChatMessage(
        id: '9',
        senderId: 'currentUser',
        senderName: '',
        content:
            'Oui, je suis en train de réviser. Quelqu\'un veut étudier ensemble demain?',
        timestamp: DateTime.now().subtract(const Duration(hours: 1)),
        isMe: true,
        messageType: MessageType.text,
      ),
      ChatMessage(
        id: '10',
        senderId: 'user3',
        senderName: widget.isGroup ? 'Karim Tazi' : '',
        content: 'Je suis disponible demain après-midi.',
        timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
        isMe: false,
        messageType: MessageType.text,
      ),
    ];

    setState(() {
      _messages.addAll(mockMessages);
    });

    // Scroll to bottom after messages are loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    final newMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      senderId: 'currentUser',
      senderName: '',
      content: _messageController.text.trim(),
      timestamp: DateTime.now(),
      isMe: true,
      messageType: MessageType.text,
    );

    setState(() {
      _messages.add(newMessage);
      _messageController.clear();
      _isAttachmentMenuOpen = false;
    });

    // Scroll to bottom after sending message
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            // Avatar
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _getAvatarColor(widget.chatName),
                shape: widget.isGroup ? BoxShape.rectangle : BoxShape.circle,
                borderRadius: widget.isGroup ? BorderRadius.circular(8) : null,
              ),
              child: Center(
                child: Icon(
                  widget.isGroup ? Icons.group : Icons.person,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Chat name and status
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.chatName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: !AppTheme.islight
                          ? Colors.white
                          : Colors.grey.shade800,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    widget.isGroup ? '28 membres' : 'En ligne',
                    style: TextStyle(
                      fontSize: 12,
                      color: !AppTheme.islight
                          ? Colors.grey.shade400
                          : Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.videocam),
            onPressed: () {
              // Video call action
            },
          ),
          IconButton(
            icon: const Icon(Icons.call),
            onPressed: () {
              // Voice call action
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // Show chat options
              _showChatOptions();
            },
          ),
        ],
      ),
      body: BackgroundImageSafeArea(
        svgAsset: Assets.bgMain,
        child: Column(
          children: [
            // Messages list
            Expanded(
              child: _messages.isEmpty
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
                            'Aucun message',
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
                            'Commencez la conversation',
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
                      controller: _scrollController,
                      padding: const EdgeInsets.all(16),
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        final message = _messages[index];
                        final bool showDate = index == 0 ||
                            !_isSameDay(message.timestamp,
                                _messages[index - 1].timestamp);
                        final bool showSender = widget.isGroup &&
                            !message.isMe &&
                            (index == 0 ||
                                _messages[index - 1].isMe ||
                                _messages[index - 1].senderId !=
                                    message.senderId);

                        return Column(
                          children: [
                            // Date separator
                            if (showDate)
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: Center(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: !AppTheme.islight
                                          ? Colors.grey.shade800
                                              .withOpacity(0.7)
                                          : Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Text(
                                      _formatMessageDate(message.timestamp),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: !AppTheme.islight
                                            ? Colors.grey.shade300
                                            : Colors.grey.shade700,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                            // Sender name for group chats
                            if (showSender)
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 12,
                                  right: 12,
                                  bottom: 4,
                                  top: showDate ? 0 : 16,
                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    message.senderName,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          _getAvatarColor(message.senderName),
                                    ),
                                  ),
                                ),
                              ),

                            // Message bubble
                            MessageBubble(
                              message: message,
                              isDarkMode: !AppTheme.islight,
                            ),
                          ],
                        );
                      },
                    ),
            ),

            // Attachment menu
            if (_isAttachmentMenuOpen)
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                color: !AppTheme.islight
                    ? Colors.grey.shade900
                    : Colors.grey.shade100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildAttachmentButton(Icons.image, 'Image', Colors.green),
                    _buildAttachmentButton(
                        Icons.insert_drive_file, 'Document', Colors.blue),
                    _buildAttachmentButton(
                        Icons.camera_alt, 'Caméra', Colors.purple),
                    _buildAttachmentButton(Icons.mic, 'Audio', Colors.orange),
                    _buildAttachmentButton(
                        Icons.location_on, 'Position', Colors.red),
                  ],
                ),
              ),

            // Message input
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                color: !AppTheme.islight ? Colors.grey.shade900 : Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Attachment button
                  IconButton(
                    icon: Icon(
                      _isAttachmentMenuOpen ? Icons.close : Icons.attach_file,
                      color: !AppTheme.islight
                          ? Colors.grey.shade400
                          : Colors.grey.shade600,
                    ),
                    onPressed: () {
                      setState(() {
                        _isAttachmentMenuOpen = !_isAttachmentMenuOpen;
                      });
                    },
                  ),
                  // Message input field
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: !AppTheme.islight
                            ? Colors.grey.shade800
                            : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: TextField(
                        controller: _messageController,
                        style: TextStyle(
                          color: !AppTheme.islight
                              ? Colors.white
                              : Colors.grey.shade800,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Message',
                          hintStyle: TextStyle(
                            color: !AppTheme.islight
                                ? Colors.grey.shade400
                                : Colors.grey.shade600,
                          ),
                          border: InputBorder.none,
                        ),
                        maxLines: null,
                        textCapitalization: TextCapitalization.sentences,
                      ),
                    ),
                  ),
                  // Send button
                  IconButton(
                    icon: Icon(
                      Icons.send,
                      color: !AppTheme.islight
                          ? Colors.blue.shade400
                          : Colors.blue.shade600,
                    ),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttachmentButton(IconData icon, String label, Color color) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: color,
            size: 24,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color:
                !AppTheme.islight ? Colors.grey.shade400 : Colors.grey.shade700,
          ),
        ),
      ],
    );
  }

  void _showChatOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: !AppTheme.islight ? Colors.grey.shade900 : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(
                Icons.search,
                color: !AppTheme.islight
                    ? Colors.grey.shade400
                    : Colors.grey.shade700,
              ),
              title: Text(
                'Rechercher dans la conversation',
                style: TextStyle(
                  color:
                      !AppTheme.islight ? Colors.white : Colors.grey.shade800,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                // Search action
              },
            ),
            if (widget.isGroup)
              ListTile(
                leading: Icon(
                  Icons.group,
                  color: !AppTheme.islight
                      ? Colors.grey.shade400
                      : Colors.grey.shade700,
                ),
                title: Text(
                  'Voir les membres',
                  style: TextStyle(
                    color:
                        !AppTheme.islight ? Colors.white : Colors.grey.shade800,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  // View members action
                },
              ),
            ListTile(
              leading: Icon(
                Icons.notifications,
                color: !AppTheme.islight
                    ? Colors.grey.shade400
                    : Colors.grey.shade700,
              ),
              title: Text(
                'Notifications',
                style: TextStyle(
                  color:
                      !AppTheme.islight ? Colors.white : Colors.grey.shade800,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                // Notifications action
              },
            ),
            ListTile(
              leading: Icon(
                Icons.delete,
                color: Colors.red.shade400,
              ),
              title: Text(
                'Supprimer la conversation',
                style: TextStyle(
                  color: Colors.red.shade400,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                // Delete action
              },
            ),
          ],
        ),
      ),
    );
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  String _formatMessageDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final messageDate = DateTime(date.year, date.month, date.day);

    if (messageDate == today) {
      return 'Aujourd\'hui';
    } else if (messageDate == yesterday) {
      return 'Hier';
    } else {
      return DateFormat('dd/MM/yyyy').format(date);
    }
  }

  Color _getAvatarColor(String name) {
    // Generate a consistent color based on the name
    final int hash = name.hashCode.abs();

    // Use a predefined set of colors
    final List<Color> colors = [
      Colors.blue.shade700,
      Colors.purple.shade700,
      Colors.green.shade700,
      Colors.orange.shade700,
      Colors.pink.shade700,
      Colors.teal.shade700,
      Colors.indigo.shade700,
      Colors.red.shade700,
    ];

    return colors[hash % colors.length];
  }
}
