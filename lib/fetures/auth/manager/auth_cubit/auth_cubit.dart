import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:x_ray2/core/errors/failure.dart';
import 'package:x_ray2/core/helper/auth_helper.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  Future<void> register(
      {required String email,
      required String password,
      required String userName,
      required String phone}) async {
    emit(AuthLoading());
    try {
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (user != null) {
        if (!user.emailVerified) {
          await user.sendEmailVerification();
          log('Verification email sent. Please check your inbox.');
        }
        bool eVerified = await waitForEmailVerification(user);
        await checkEmailVerification(user);

        if (eVerified) {
          await FirebaseFirestore.instance.collection('users').add({
            "email": email,
            "userName": userName,
            "phone": phone,
          });

          emit(AuthSuccess());
          log('User account created successfully.');
        } else {
          // If email verification fails, delete the user and throw an exception
          await user.delete();
          emit(AuthFailure(errMessage: 'Email verification failed.'));
        }
      }
    } catch (e) {
      // Catch any type of error or use specific Firebase exception
      String errorMessage;
      if (e is FirebaseAuthException) {
        errorMessage =
            FirebaseFailure.fromFirebaseException(e).errMessage.toString();
      } else {
        errorMessage = 'An unexpected error occurred.';
      }
      emit(AuthFailure(errMessage: errorMessage));
    }
  }

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      emit(AuthSuccess());
    } catch (e) {
      emit(
        AuthFailure(
          errMessage: FirebaseFailure.fromFirebaseException(e as Exception)
              .errMessage
              .toString(),
        ),
      );
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    emit(AuthLoading());
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      // Force sign out from any previous Google account
      await googleSignIn.signOut();

      // Trigger the authentication flow and prompt for account selection
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        // Handle the case where the user cancels the sign-in
        throw FirebaseAuthException(
          code: 'sign_in_canceled',
          message: 'Sign-in was canceled by the user.',
        );
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      emit(LoginWithGoogle());
      // Once signed in, return the UserCredential
      return userCredential;
    } catch (e) {
      // Log and rethrow any other exceptions
      log('Exception: ${e.toString()}');
      emit(AuthFailure(
          errMessage: FirebaseFailure.fromFirebaseException(e as Exception)
              .errMessage
              .toString()));
    }
    return null;
  }

  Future<void> resetPassword(String email) async {
    emit(AuthLoading());
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(
          errMessage: FirebaseFailure.fromFirebaseException(e as Exception)
              .errMessage
              .toString()));
    }
  }

  Future<void> forgotPassword({required String email}) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      // Check if the user with the given email exists
      if (querySnapshot.docs.isNotEmpty) {
        // If email is found, send the password reset email
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      } else {
        // If email is not found, throw an exception or handle it accordingly
        throw Exception('No user found with this email');
      }
    } on FirebaseAuthException catch (err) {
      // Handle FirebaseAuth specific errors
      throw Exception(err.message.toString());
    } catch (err) {
      // Handle any other errors
      throw Exception(err.toString());
    }
  }
}
