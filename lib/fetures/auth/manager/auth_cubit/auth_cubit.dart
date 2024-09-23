import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:x_ray2/core/errors/failure.dart';
import 'package:x_ray2/core/helper/auth_helper.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> register(
      {required String email, required String password}) async {
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
          // await firestore.collection('users').doc(user.uid).set({
          //   'uid': user.uid,
          //   'email': email,
          //  // 'username': username,
          //   // Add other fields as needed
          // });
          // await FirebaseFirestore.instance.collection('users').add({
          //   "email": email,
          // });

          emit(AuthSuccess());
       
          log('User account created successfully.');
        } else {
          // If email verification fails, delete the user and throw an exception
          await user.delete();
          emit(AuthFailure(errMessage: 'Email verification failed.'));
        }
      }
    } catch (e) {
      emit(AuthFailure(
          errMessage: FirebaseFailure.fromFirebaseException(e as Exception)
              .errMessage
              .toString()));
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

      emit(AuthSuccess());
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





}