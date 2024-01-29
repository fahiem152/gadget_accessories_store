import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String uid,
    required String email,
    required String name,
    String? photoUrl,
    @Default(0) int balance,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  factory UserModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return UserModel(
      uid: snapshot.id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
    );
  }
  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      uid: user.uid,
      name: user.email!.replaceAll('@gmail.com', ''),
      email: user.email!,
    );
  }
}
