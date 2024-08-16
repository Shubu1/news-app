import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_connect/src/features/authentication/domain/model/user_model.dart';

abstract class UserRepository {
  Stream<User?> get user;
  Future<MyUser> signUp(MyUser myUser, String password);
  Future<void> setUserData(MyUser user);
  Future<void> signIn(String email, String password);
}
