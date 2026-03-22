import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:job_contract_app/presentation/features/users/message/widgets/ConversationTile.dart';
import 'package:provider/provider.dart';

import '../../../../utils/common_widgets/appbar.dart';
import '../../../../utils/common_widgets/circular_avatar.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/app_text_style.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../../utils/device/device_utility.dart';
import '../../../routes/app_routes.dart';
import '../home/drawer/custom_navigation_drawer.dart';
import '../../../../data/models/chat/ChatModel2.dart';  // ← ChatModel2
import '../providers/message_provider.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MessageProvider>().fetchConversations();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String _formatTime(DateTime? dt) {
    if (dt == null) return '';
    final local = dt.toLocal();
    final hour = local.hour % 12 == 0 ? 12 : local.hour % 12;
    final minute = local.minute.toString().padLeft(2, '0');
    final period = local.hour >= 12 ? 'pm' : 'am';
    return '$hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);
    final provider = context.watch<MessageProvider>();

    // ── Filter by otherUser.fullName or lastMessage text ─────
    final List<ChatModel2> filtered = _searchQuery.isEmpty
        ? provider.conversations
        : provider.conversations.where((chat) {
      final name = chat.otherUser.fullName.toLowerCase();
      final msg = chat.lastMessage?.preview.toLowerCase() ?? '';
      return name.contains(_searchQuery.toLowerCase()) ||
          msg.contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: isDark ? JAppColors.backGroundDark : Colors.white,
      drawer: CustomNavigationDrawer(isDark: isDark),
      key: _scaffoldKey,

      appBar: JAppbar(
        title: Text(
          'message',
          style: AppTextStyle.dmSans(
            fontSize: 18.0,
            weight: FontWeight.w500,
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
          ),
        ).tr(),
        leadingIcon: GestureDetector(
          onTap: () => _scaffoldKey.currentState?.openDrawer(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularAvatar(
              isDark: isDark,
              radius: 20,
              imageUrl: JImages.image,
            ),
          ),
        ),
        actions: [
          if (provider.isLoading)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            )
          else
            IconButton(
              icon: Icon(
                Icons.refresh,
                color: isDark ? JAppColors.darkGray100 : JAppColors.darkGray800,
              ),
              onPressed: () =>
                  context.read<MessageProvider>().fetchConversations(),
            ),
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: isDark ? JAppColors.darkGray100 : JAppColors.darkGray800,
            ),
            onPressed: () {},
          ),
        ],
      ),

      body: Column(
        children: [

          // ── Search Bar ───────────────────────────────────────
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: isDark ? JAppColors.darkGray700 : Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  SvgPicture.asset(
                    JImages.search,
                    width: 20,
                    height: 20,
                    colorFilter: ColorFilter.mode(
                      isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      onChanged: (v) => setState(() => _searchQuery = v),
                      decoration: InputDecoration(
                        hintText: 'Search message',
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintStyle: TextStyle(
                          color: isDark ? JAppColors.lightGray100 : Colors.grey,
                        ),
                      ),
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  if (_searchQuery.isNotEmpty)
                    GestureDetector(
                      onTap: () {
                        _searchController.clear();
                        setState(() => _searchQuery = '');
                      },
                      child: Icon(
                        Icons.close,
                        size: 18,
                        color: isDark ? JAppColors.lightGray100 : Colors.grey,
                      ),
                    ),
                ],
              ),
            ),
          ),

          // ── Error Banner ─────────────────────────────────────
          if (provider.errorMessage != null)
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      provider.errorMessage!,
                      style: const TextStyle(color: Colors.red, fontSize: 13),
                    ),
                  ),
                  GestureDetector(
                    onTap: () =>
                        context.read<MessageProvider>().fetchConversations(),
                    child: const Text(
                      'Retry',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // ── Conversation List ─────────────────────────────────
          Expanded(
            child: provider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : filtered.isEmpty
                ? _buildEmptyState(isDark)
                : RefreshIndicator(
              onRefresh: () =>
                  context.read<MessageProvider>().fetchConversations(),
              child: ListView.builder(
                itemCount: filtered.length,
                itemBuilder: (context, index) {
                  final ChatModel2 chat = filtered[index];

                  return ConversationTile(
                    isDark: isDark,
                    name: chat.otherUser.fullName,         // ✅
                    avatarUrl: chat.otherUser.profile,     // ✅
                    lastMessage: chat.lastMessage?.preview ?? '',  // ✅
                    time: _formatTime(
                      chat.lastMessage?.createdAt ?? chat.updatedAt,
                    ),
                    unreadCount: chat.unreadCount,         // ✅
                    isOnline: chat.otherUser.isOnline,     // ✅
                    onTap: () => AppRouter.router.push(
                      '/chatScreen',
                      extra: chat,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(bool isDark) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.chat_bubble_outline,
            size: 64,
            color: isDark ? JAppColors.darkGray500 : Colors.grey[400],
          ),
          const SizedBox(height: 12),
          Text(
            _searchQuery.isNotEmpty
                ? 'No results for "$_searchQuery"'
                : 'No conversations yet',
            style: AppTextStyle.dmSans(
              fontSize: 14.0,
              weight: FontWeight.w400,
              color: isDark ? JAppColors.darkGray500 : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}