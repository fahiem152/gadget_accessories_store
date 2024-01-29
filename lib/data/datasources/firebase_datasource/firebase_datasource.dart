import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:projecttas_223200007/data/models/product_model.dart';
import 'package:projecttas_223200007/data/models/top_up_model.dart';
import 'package:projecttas_223200007/data/models/transaction_model.dart';
import 'package:projecttas_223200007/data/models/user_model.dart';

class FirebaseDatasource {
  final _firebaseFirestore = FirebaseFirestore.instance;
  final _firebaseAuth = FirebaseAuth.instance;
  final CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('products');
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<String> register(
      {required String email, required String password}) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await userCredential.user!.sendEmailVerification();
      return userCredential.user!.uid;
    } on FirebaseAuthException catch (e) {
      log("Failed: $e");
      return "Failed: $e";
    }
  }

  Future<String> login(
      {required String email, required String password}) async {
    try {
      final result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (email == 'admin@gmail.com') {
        return "Success Login";
      } else {
        if (result.user!.emailVerified) {
          return "Success Login";
        } else {
          return "Please verify your email first as we have already sent the verification email.";
        }
      }
    } on FirebaseAuthException catch (e) {
      log("Failed: $e");
      return "Failed Login Make Sure Email and Password";
    }
  }

  Future<bool> signInWithGoogle() async {
    try {
      GoogleSignInAccount? account = await GoogleSignIn().signIn();
      log("IDTOKEN: ${account}");
      if (account != null) {
        GoogleSignInAuthentication auth = await account.authentication;

        AuthCredential credential = GoogleAuthProvider.credential(
          idToken: auth.idToken,
          accessToken: auth.accessToken,
        );

        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);

        if (userCredential.user != null) {
          bool isUserExist =
              await isUserExistInDatabase(userCredential.user!.uid);

          if (!isUserExist) {
            String createUserResult = await createUser(
              uid: userCredential.user!.uid,
              email: userCredential.user!.email!,
              name: userCredential.user!.displayName ?? '',
              photoUrl: userCredential.user!.photoURL,
              balance: 0,
            );

            if (createUserResult != "Success") {
              log('Failed to create user: $createUserResult');
              return false;
            }
          }

          return true;
        } else {
          log('User is null after login');
          return false;
        }
      } else {
        log('Google sign in account is null');
        return false;
      }
    } catch (e) {
      log('Failed: $e');
      return false;
    }
  }

  Future<String> changePassword(String oldPassword, String newPassword) async {
    User? user = _firebaseAuth.currentUser;

    if (user != null) {
      try {
        AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: oldPassword,
        );

        await user.reauthenticateWithCredential(credential);
        await user.updatePassword(newPassword);

        return ("Successfully changed password");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          return ('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          return ('Wrong password provided for that user.');
        } else {
          return ('Error: ${e.message}');
        }
      }
    } else {
      return ('User is null. Please sign in.');
    }
  }

  Future<String> logout() async {
    try {
      await _firebaseAuth.signOut();
      return "Success Log Out";
    } on FirebaseAuthException catch (e) {
      log("Failed: $e");
      return "Failed Log Out";
    }
  }

  Future<String> createUser(
      {required String uid,
      required String email,
      required String name,
      String? photoUrl,
      int balance = 0}) async {
    CollectionReference<Map<String, dynamic>> users =
        _firebaseFirestore.collection('users');
    await users.doc(uid).set({
      "uid": uid,
      "email": email,
      "name": name,
      "photoUrl": photoUrl,
      "balance": balance,
    });
    DocumentSnapshot<Map<String, dynamic>> result = await users.doc(uid).get();
    if (result.exists) {
      UserModel.fromJson(result.data()!);
      return "Success";
    } else {
      return "Failed to Create User";
    }
  }

  Future<UserModel?> getUserByUid({required String uid}) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> result =
          await _firebaseFirestore.doc('users/$uid').get();

      if (result.exists) {
        return UserModel.fromJson(result.data()!);
      } else {
        print('User not found with UID: $uid');
        return null;
      }
    } catch (error) {
      print('Error getting user with UID $uid: $error');
      return null;
    }
  }

  Future<List<String>> uploadImages(List<File> images, String productId) async {
    List<String> imageUrls = [];

    for (int i = 0; i < images.length; i++) {
      String imageName = "image_${DateTime.now().millisecondsSinceEpoch}.jpg";
      String imagePath = "products/$productId/$imageName";

      final storageRef = FirebaseStorage.instance.ref().child(imagePath);

      await storageRef.putFile(images[i]);

      String imageUrl = await storageRef.getDownloadURL();
      imageUrls.add(imageUrl);
    }

    return imageUrls;
  }

  Future<String> uploadFileUser(File file, String userId) async {
    String fileName = "file_${DateTime.now().millisecondsSinceEpoch}";
    String filePath = "users/$userId/files/$fileName";

    final storageRef = FirebaseStorage.instance.ref().child(filePath);

    await storageRef.putFile(file);

    String fileUrl = await storageRef.getDownloadURL();
    return fileUrl;
  }

  Future<bool> addProduct(ProductModel model, List<File> images) async {
    try {
      DocumentReference productRef = await FirebaseFirestore.instance
          .collection("products")
          .add(model.toJson());
      String productId = productRef.id;
      List<String> imageUrls = await uploadImages(images, productId);
      ProductModel updatedModel =
          model.copyWith(images: imageUrls, id: productId);
      await productRef.update(updatedModel.toJson());
      return true;
    } catch (e) {
      log("Failed: $e");
      return false;
    }
  }

  Stream<List<ProductModel>> getProducts() {
    return FirebaseFirestore.instance.collection("products").snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) => ProductModel.fromJson(doc.data()))
            .toList());
  }

  Future<List<ProductModel>> getProductsV2() async {
    QuerySnapshot productSnapshot =
        await FirebaseFirestore.instance.collection('products').get();

    List<ProductModel> products = [];
    for (var doc in productSnapshot.docs) {
      products.add(ProductModel.fromJson(doc.data() as Map<String, dynamic>));
    }

    return products;
  }

  Future<bool> editProduct(ProductModel model, List<File> images) async {
    try {
      DocumentReference productRef =
          FirebaseFirestore.instance.collection("products").doc(model.id);

      List<String> imageUrls = model.images;
      List<String> newImageUrls = [];
      log("Running  imageUrls: $imageUrls");
      if (images.isNotEmpty) {
        newImageUrls = await uploadImages(images, model.id);
      }
      List<String> updateImageUrls = [...imageUrls, ...newImageUrls];
      log("Running  newImageUrls: $newImageUrls");
      log("Running  mageUrlsseteleh upload digabungkan: $updateImageUrls");
      ProductModel updatedModel = model.copyWith(
        images: updateImageUrls,
      );
      await productRef.update(updatedModel.toJson());
      return true;
    } catch (e) {
      log("Failed: $e");
      return false;
    }
  }

  Future<bool> deleteProduct(String productId) async {
    try {
      DocumentReference productRef =
          FirebaseFirestore.instance.collection("products").doc(productId);

      await productRef.delete();

      return true;
    } catch (e) {
      log("Failed: $e");
      return false;
    }
  }

  Future<String> addTransaction(
    TransactionModel model,
  ) async {
    try {
      UserModel? user;
      final result = await getUserByUid(uid: model.uid);
      user = result;
      if (user != null) {
        if (user.balance > int.parse(model.total)) {
          DocumentReference transactiontRef = await FirebaseFirestore.instance
              .collection("transactions")
              .add(model.toJson());
          String transactiontId = transactiontRef.id;
          TransactionModel updatedModel = model.copyWith(
              id: "GAS-${model.uid}-$transactiontId-${DateTime.now().millisecondsSinceEpoch}");
          await transactiontRef.update(updatedModel.toJson());
          await updateBalanceUser(user, int.parse(model.total), isTopUp: false);
          return "Your transaction has been completed successfully";
        } else {
          log("Insufficient funds. Please top up your balance before proceeding with the transaction.");
          return "Insufficient funds. Please top up your balance before proceeding with the transaction.";
        }
      } else {
        log("Failed: User Null");
        return "User failed. Please Logout and Login Again";
      }
    } catch (e) {
      log("Failed: $e");
      return 'Transaction failed. Please try again';
    }
  }

  Stream<List<TransactionModel>> getTransactions() {
    return FirebaseFirestore.instance
        .collection("transactions")
        .orderBy("transactionTime", descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => TransactionModel.fromJson(doc.data()))
            .toList());
  }

  Stream<List<TransactionModel>> getTransactionsByUid(String uid) {
    return FirebaseFirestore.instance
        .collection("transactions")
        .where("uid", isEqualTo: uid)
        .orderBy("transactionTime", descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => TransactionModel.fromJson(doc.data()))
            .toList());
  }

  Future<bool> editUser(UserModel user) async {
    try {
      UserModel updatedModel = user.copyWith(
        name: user.name,
        photoUrl: user.photoUrl,
      );
      await usersCollection.doc(user.uid).update(updatedModel.toJson());
      return true;
    } catch (e) {
      log("Failed: $e");
      return false;
    }
  }

  Future<bool> updateBalanceUser(UserModel user, int amount,
      {bool isTopUp = true}) async {
    try {
      int newBalance = isTopUp ? user.balance + amount : user.balance - amount;
      UserModel updatedModel = user.copyWith(balance: newBalance);
      await usersCollection.doc(user.uid).update(updatedModel.toJson());
      return true;
    } catch (e) {
      log("Failed: $e");
      return false;
    }
  }

  Future<bool> addTopUp(TopUpModel model) async {
    try {
      DocumentReference topUpRef = await FirebaseFirestore.instance
          .collection("topups")
          .add(model.toJson());
      String topUpId = topUpRef.id;

      TopUpModel updatedModel = model.copyWith(
        uid:
            "GAS-TP-${model.userUid}-$topUpId-${DateTime.now().millisecondsSinceEpoch}",
        timestamp: DateTime.now().millisecondsSinceEpoch,
      );
      await topUpRef.update(updatedModel.toJson());
      return true;
    } catch (e) {
      log("Failed: $e");
      return false;
    }
  }

  Stream<List<TopUpModel>> getTopUpByUid(String uid) {
    log("Running: getTopUpByUid");
    return FirebaseFirestore.instance
        .collection("topups")
        .where("userUid", isEqualTo: uid)
        .orderBy("timestamp", descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => TopUpModel.fromJson(doc.data()))
            .toList());
  }

  Stream<List<TopUpModel>> getTopUps() {
    return FirebaseFirestore.instance
        .collection("topups")
        .orderBy("timestamp", descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => TopUpModel.fromJson(doc.data()))
            .toList());
  }

  Future<bool> isUserExistInDatabase(String uid) async {
    try {
      CollectionReference<Map<String, dynamic>> usersCollection =
          FirebaseFirestore.instance.collection('users');

      DocumentSnapshot<Map<String, dynamic>> userDoc =
          await usersCollection.doc(uid).get();

      if (userDoc.exists) {
        return true; // Dokumen pengguna ditemukan
      } else {
        return false; // Dokumen pengguna tidak ditemukan
      }
    } catch (e) {
      print('Error checking user existence: $e');
      return false; // Mengembalikan false jika terjadi kesalahan
    }
  }
}
