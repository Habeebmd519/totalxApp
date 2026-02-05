import 'package:totelxapp/models/user.dart';

class UserState {
  final List<User> users;
  final String? selectedImagePath;
  final String activeFilter; // The variable definition

  // The Constructor - this is where 'activeFilter' was likely missing
  UserState({
    required this.users,
    this.selectedImagePath,
    this.activeFilter = 'All', // Default value is 'All'
  });
}
