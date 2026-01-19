import 'package:amk_bank_project/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<UserModel> login(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    if (email == "test@amk.com" && password == "password123") {
      return UserModel(id: "1", name: "Test User", email: email);
    } else {
      throw Exception("Invalid email or password");
    }
  }
}
