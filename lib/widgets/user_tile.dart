import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String name;
  final int age;

  const UserTile({super.key, required this.name, required this.age});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.person)),
        title: Text(name),
        subtitle: Text("Age: $age"),
      ),
    );
  }
}
