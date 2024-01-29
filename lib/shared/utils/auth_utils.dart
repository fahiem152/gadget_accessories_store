import 'package:firebase_auth/firebase_auth.dart';

class AuthUtils {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static String? getCurrentUserID() {
    User? user = _auth.currentUser;
    if (user != null) {
      String uid = user.uid;
      return uid;
    } else {
      return null; // Pengguna tidak login
    }
  }
}