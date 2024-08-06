import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hmj_apps/core/controller/base_controller.dart';
import 'package:hmj_apps/core/route/routes.dart';
import 'package:hmj_apps/model/user_model.dart';

class AuthController extends BaseController {
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  static AuthController find = Get.find<AuthController>();

  late final Stream<User?> authStream;
  final Rxn<UserModel> _currentUser = Rxn();
  UserModel? get currentUser => _currentUser.value;
  @override
  void onInit() {
    authStream = FirebaseAuth.instance.authStateChanges();
    authStream.listen((user) {
      if (user != null) {
        getUser();
        Get.offAllNamed(AppRoute.navigation);
      } else {
        if (!(Get.currentRoute == "/")) {
          Get.offAllNamed(AppRoute.loginPage);
        }
        _currentUser.value = null;
      }
    });
    super.onInit();
  }

  User? get firebaseCrrentUser => FirebaseAuth.instance.currentUser;

  void getUser() async {
    if (firebaseCrrentUser != null) {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseCrrentUser!.uid)
          .get();

      if (snapshot.data() == null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(firebaseCrrentUser?.uid)
            .set({
          'name': firebaseCrrentUser?.displayName,
          'address': '',
          'phoneNumber': firebaseCrrentUser?.phoneNumber,
          'joinedAt': DateTime.now().millisecondsSinceEpoch,
        });
        _currentUser.value = UserModel(
          id: firebaseCrrentUser?.uid ?? '',
          name: firebaseCrrentUser?.displayName,
          joinedAt: DateTime.now(),
          address: "",
          phoneNumber: firebaseCrrentUser?.phoneNumber,
        );
      } else {
        _currentUser.value = UserModel.fromSnapshot(snapshot);
      }
    } else {
      FirebaseAuth.instance.signOut();
    }
  }

  void loginWithGoogle() async {
    try {
      showLoading();
      final googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      if (googleAuth != null) {
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final authResult =
            await FirebaseAuth.instance.signInWithCredential(credential);

        if (authResult.additionalUserInfo?.isNewUser ?? false) {
          FirebaseFirestore.instance
              .collection('users')
              .doc(authResult.user?.uid)
              .set(
            {
              "name": authResult.user?.displayName,
              "phone": authResult.user?.phoneNumber ?? '',
              "address": "",
              "joinedAt": DateTime.now().toIso8601String(),
            },
          );
        }
      }
    } on FirebaseAuthException catch (error) {
      Get.back();
      showErrorSnackbar(
          errorMessage: error.message ?? 'Terjadi kesalahan server.');
    } catch (error) {
      Get.back();
      showErrorSnackbar(errorMessage: "Masuk dengan Google gagal.");
    }
  }

  void loginWithEmailAndPassword() async {
    if (formKey.currentState?.saveAndValidate() ?? false) {
      showLoading();
      final email = formKey.currentState!.value['email'];
      final password = formKey.currentState!.value['password'];
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        Get.back();
        //Get.toNamed(AppRoute.dashboardPage);
        Get.toNamed(AppRoute.navigation);
        showSuccessSnackbar(message: "Berhasil masuk!");
      } on FirebaseAuthException catch (error) {
        Get.back();
        showErrorSnackbar(
            errorMessage: error.message ?? 'Terjadi kesalahan server.');
      }
    }
  }
}
