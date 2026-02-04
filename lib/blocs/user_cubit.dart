import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/user.dart';

class UserCubit extends Cubit<List<User>> {
  UserCubit() : super([]);

  void addUser(User user) {
    final updated = [...state, user];
    emit(updated);
  }

  void sortByAge() {
    final sorted = [...state]..sort((a, b) => a.age.compareTo(b.age));
    emit(sorted);
  }

  void search(String query) {
    final filtered = state
        .where((u) => u.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    emit(filtered);
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
