import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fs_task_assesment/models/user.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> saveUserData({required UserModel user}) async {
    try {
      await _firestore
          .collection('users')
          .doc(user.uid)
          .set({
            'uid': user.uid,
            'name': user.name,
            'email': user.email,
            'password': user.password,
          })
          .then((value) {
            return true;
          })
          .onError((error, stackTrace) {
            return false;
          });

      return false;
    } on FirebaseException catch (exception) {
      throw Exception(exception.message.toString());
    } catch (err) {
      throw Exception(err.toString());
    }
  }
}
