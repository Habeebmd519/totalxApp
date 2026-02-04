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
