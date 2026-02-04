import 'package:flutter/material.dart';
import 'package:totelxapp/models/user.dart';
import '../widgets/user_tile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/user_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Nilambur")),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddUser(context),
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<UserCubit, List<User>>(
        builder: (context, users) {
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (_, i) =>
                UserTile(name: users[i].name, age: users[i].age),
          );
        },
      ),
    );
  }

  void _showAddUser(BuildContext context) {
    final nameController = TextEditingController();
    final ageController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Name"),
              ),
              TextField(
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Age"),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  context.read<UserCubit>().addUser(
                    User(
                      name: nameController.text,
                      age: int.parse(ageController.text),
                    ),
                  );

                  Navigator.pop(context);
                },
                child: const Text("Save"),
              ),
            ],
          ),
        );
      },
    );
  }
}
