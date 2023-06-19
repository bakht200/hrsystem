import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());

  signInUser(email, password) async {
    emit(AuthenticationLoading());
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(AuthenticationSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(AuthenticationUserNotFound());
      } else if (e.code == 'wrong-password') {
        emit(AuthenticationPasswordError());

        print('Wrong password provided for that user.');
      }
    } on SocketException {
      emit(AuthenticationInternetError());
    } catch (e) {
      emit(AuthenticationFailed());
    }
  }
}
