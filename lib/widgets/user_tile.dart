import 'dart:io'; // 1. Add this import for File
import 'package:flutter/material.dart';
import 'package:totelxapp/models/user.dart';

class UserTile extends StatelessWidget {
  final User user;

  const UserTile({required this.user, super.key}); // Added super.key

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // 2. Updated CircleAvatar Logic
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey.shade200,
            backgroundImage:
                (user.imagePath != null && user.imagePath!.isNotEmpty)
                ? FileImage(File(user.imagePath!)) // Use the saved local image
                : NetworkImage("https://i.pravatar.cc/150?img=${user.age}")
                      as ImageProvider,
          ),

          const SizedBox(width: 15),

          /// Name + Age
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Age: ${user.age}",
                style: const TextStyle(color: Colors.black54),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
