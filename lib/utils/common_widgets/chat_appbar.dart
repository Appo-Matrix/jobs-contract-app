import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String userName;
  final bool isOnline;
  final String userAvatar;

  const ChatAppBar({
    Key? key,
    required this.userName,
    required this.isOnline,
    required this.userAvatar,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: const BackButton(color: Colors.black),
      title: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(userAvatar),
            radius: 20,
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Text(
                    isOnline ? 'Online' : 'Offline',
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(width: 5),
                  CircleAvatar(
                    backgroundColor: isOnline ? Colors.green : Colors.grey,
                    radius: 4,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
