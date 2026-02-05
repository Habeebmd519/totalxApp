import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:totelxapp/blocs/user_state.dart';
import '../models/user.dart';

class UserCubit extends Cubit<UserState> {
  final Box<User> _userBox = Hive.box<User>('users');
  final ImagePicker _picker = ImagePicker();

  UserCubit() : super(UserState(users: [])) {
    loadUsers(); // Load from Hive on startup
  }

  // Load from Hive
  void loadUsers() {
    emit(UserState(users: _userBox.values.toList()));
  }

  // Image Picking Logic
  Future<void> pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50, // Pro-tip: Compress to save Hive storage space
      );

      if (image != null) {
        emit(UserState(users: state.users, selectedImagePath: image.path));
      }
    } catch (e) {
      print("Error picking image: $e");
      // You can emit an error state here if you want to show a SnackBar
    }
  }

  // Save to Hive
  Future<void> addUser(String name, int age) async {
    final newUser = User(
      name: name,
      age: age,
      imagePath: state.selectedImagePath,
    );

    await _userBox.add(newUser); // Save to local DB
    emit(
      UserState(
        users: _userBox.values.toList(),
        selectedImagePath: null, // Clear image for next time
      ),
    );
  }

  // Sorting
  // To Filter
  void filterByAge(String category) {
    final allUsers = _userBox.values.toList();
    List<User> filtered;

    if (category == 'Elder') {
      filtered = allUsers.where((u) => u.age >= 60).toList();
    } else if (category == 'Younger') {
      filtered = allUsers.where((u) => u.age < 60).toList();
    } else {
      filtered = allUsers;
    }

    emit(
      UserState(
        users: filtered,
        selectedImagePath: state.selectedImagePath,
        activeFilter: category, // Passing it here fixes the error
      ),
    );
  }

  // To Clear/Search/Add
  void loadUserd() {
    emit(
      UserState(
        users: _userBox.values.toList(),
        selectedImagePath: state.selectedImagePath,
        activeFilter: 'All', // Reset to All
      ),
    );
  }

  // Search
  void search(String query) {
    if (query.isEmpty) {
      loadUsers();
      return;
    }
    final filtered = _userBox.values
        .where((u) => u.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    emit(
      UserState(users: filtered, selectedImagePath: state.selectedImagePath),
    );
  }
}

// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../models/user.dart';

// class UserCubit extends Cubit<List<User>> {
//   UserCubit() : super(_dummyUsers()); // ✅ load temp users at start

//   /// -------------------------
//   /// Temporary testing data
//   /// -------------------------
//   static List<User> _dummyUsers() {
//     return [
//       User(name: "Martin Dokdis", age: 34),
//       User(name: "Marilyn Rosser", age: 62),
//       User(name: "Cristofer Lipshutz", age: 28),
//       User(name: "Wilson Botosh", age: 31),
//       User(name: "Anika Saris", age: 26),
//       User(name: "Phillip Gouse", age: 45),
//       User(name: "Wilson Bergson", age: 39),
//       User(name: "James Carter", age: 52),
//       User(name: "Sophia Miller", age: 22),
//       User(name: "Daniel Scott", age: 41),
//     ];
//   }

//   /// Add new user
//   void addUser(User user) {
//     final updated = List<User>.from(state)..add(user);
//     emit(updated);
//   }

//   /// Remove user
//   void removeUser(User user) {
//     final updated = List<User>.from(state)..remove(user);
//     emit(updated);
//   }
// }
