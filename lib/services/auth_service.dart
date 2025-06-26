import 'package:firebase_auth/firebase_auth.dart';
import 'package:fs_task_assesment/helpers/app_data.dart';
import 'package:fs_task_assesment/helpers/sp_helper.dart';
import 'package:fs_task_assesment/models/user.dart';
import 'package:fs_task_assesment/services/user_service.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<AuthResponse> signUpUser({
    required UserModel userModel,
    required UserService userService,
  }) async {
    try {
      final UserCredential value = await _firebaseAuth
          .createUserWithEmailAndPassword(
            email: userModel.email,
            password: userModel.password,
          );

      if (value.user != null) {
        final User? firebaseUser = _firebaseAuth.currentUser;

        if (firebaseUser != null) {
          UserModel user = UserModel(
            uid: firebaseUser.uid,
            name: userModel.name,
            email: userModel.email,
            password: userModel.password,
          );

          AppData.shared.user = user;

          await userService.saveUserData(user: user);
        }

        String? idToken = await value.user?.getIdToken();

        if (idToken != null) {
          await SpHelper.addOrUpdateAccessToken(idToken);
        }

        return AuthResponse(status: true, message: "Welcome to FS Programming");
      }

      return AuthResponse(status: false, message: "Unknown error occurred");
    } on FirebaseAuthException catch (e) {
      return AuthResponse(
        status: false,
        message: e.message ?? "Authentication error",
      );
    } catch (e) {
      return AuthResponse(status: false, message: e.toString());
    }
  }

  Future<AuthResponse> signInUser({
    required String email,
    required String password,
    required UserService userservice,
  }) async {
    try {
      final UserCredential result = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      final User? user = result.user;

      if (user != null) {
        String? idToken = await result.user?.getIdToken();

        if (idToken != null) {
          SpHelper.addOrUpdateAccessToken(idToken);
        }

        UserModel? user = await userservice.getUserData(
          userId: _firebaseAuth.currentUser?.uid ?? '',
        );

        AppData.shared.user = user;

        return AuthResponse(status: true, message: "Welcome Back");
      }

      return AuthResponse(status: false, message: "Unknown Exception occoured");
    } on FirebaseAuthException catch (err) {
      return AuthResponse(status: false, message: err.message.toString());
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future<bool> signOutUser() async {
    try {
      SpHelper.removeAllData();
      await _firebaseAuth.signOut();

      return true;
    } on FirebaseAuthException catch (err) {
      throw Exception(err.message.toString());
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future<AuthResponse> checkLoginStatus(UserService userService) async {
    String? accessToken = await SpHelper.readAccessToken();

    if (accessToken != null && _firebaseAuth.currentUser != null) {
      final currentUser = _firebaseAuth.currentUser;
      if (currentUser != null) {
        UserModel? user = await userService.getUserData(
          userId: _firebaseAuth.currentUser?.uid ?? '',
        );

        if (user != null) {
          AppData.shared.user = user;

          return AuthResponse(
            status: true,
            message: "User Data Fetched",
            userModel: user,
          );
        }
      }
    }
    return AuthResponse(status: false, message: "Error checking Login Status");
  }
}

class AuthResponse {
  final bool status;
  final String message;
  final UserModel? userModel;
  AuthResponse({required this.status, required this.message, this.userModel});
}
