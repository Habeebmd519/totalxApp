import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totelxapp/blocs/user_state.dart';
import 'package:totelxapp/widgets/user_tile.dart';
import '../blocs/user_cubit.dart';
import 'dart:io';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        shape: const CircleBorder(),
        onPressed: () => _showAddUserDialog(context),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Top Location Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black, Colors.black87],
                ),
              ),
              child: const Row(
                children: [
                  Icon(Icons.location_on, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    "Nilambur",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // Search and Filter Row
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: TextField(
                        onChanged: (value) => context.read<UserCubit>().search(
                          value,
                        ), // LOGIC ADDED
                        decoration: const InputDecoration(
                          icon: Icon(Icons.search),
                          hintText: "search by name",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () => _showSortBottomSheet(context), // LOGIC ADDED
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.tune, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Users Lists",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // User List
            Expanded(
              child: BlocBuilder<UserCubit, UserState>(
                builder: (context, state) {
                  if (state.users.isEmpty) {
                    return const Center(child: Text("No users found"));
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: state.users.length,
                    itemBuilder: (_, i) => UserTile(user: state.users[i]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Sort Bottom Sheet (Matches your Screenshot) ---
  void _showSortBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (sheetContext) {
        return BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Sort",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  RadioListTile<String>(
                    title: const Text("All"),
                    value: 'All',
                    groupValue: state.activeFilter,
                    activeColor: Colors.blueAccent,
                    onChanged: (val) {
                      context.read<UserCubit>().filterByAge('All');
                      Navigator.pop(sheetContext);
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text("Age: Elder"),
                    value: 'Elder',
                    groupValue: state.activeFilter,
                    activeColor: Colors.blueAccent,
                    onChanged: (val) {
                      context.read<UserCubit>().filterByAge('Elder');
                      Navigator.pop(sheetContext);
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text("Age: Younger"),
                    value: 'Younger',
                    groupValue: state.activeFilter,
                    activeColor: Colors.blueAccent,
                    onChanged: (val) {
                      context.read<UserCubit>().filterByAge('Younger');
                      Navigator.pop(sheetContext);
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // --- Add User Dialog ---
  void _showAddUserDialog(BuildContext context) {
    final nameController = TextEditingController();
    final ageController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                left: 24,
                right: 24,
                top: 24,
                bottom: MediaQuery.of(context).viewInsets.bottom + 24,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Add A New User',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),

                  // Profile Avatar Logic
                  BlocBuilder<UserCubit, UserState>(
                    builder: (context, state) {
                      return Center(
                        child: GestureDetector(
                          onTap: () => context.read<UserCubit>().pickImage(),
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.blue.shade100,
                                backgroundImage: state.selectedImagePath != null
                                    ? FileImage(File(state.selectedImagePath!))
                                    : null,
                                child: state.selectedImagePath == null
                                    ? const Icon(
                                        Icons.person,
                                        size: 60,
                                        color: Colors.blue,
                                      )
                                    : null,
                              ),
                              Container(
                                height: 30,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.3),
                                  borderRadius: const BorderRadius.vertical(
                                    bottom: Radius.circular(50),
                                  ),
                                ),
                                child: const Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text("Name", style: TextStyle(color: Colors.grey)),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: "Shaukath Ali OP",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text("Age", style: TextStyle(color: Colors.grey)),
                  TextField(
                    controller: ageController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "43",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Buttons with Expanded to prevent overflows
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () => Navigator.pop(dialogContext),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.grey.shade200,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            "Cancel",
                            style: TextStyle(color: Colors.black54),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            final name = nameController.text;
                            final age = int.tryParse(ageController.text) ?? 0;
                            if (name.isNotEmpty) {
                              context.read<UserCubit>().addUser(name, age);
                              Navigator.pop(dialogContext);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4285F4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            "Save",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
