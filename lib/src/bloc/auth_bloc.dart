import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_bloc/src/bloc/auth_event.dart';
import 'package:flutter_auth_bloc/src/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AuthBloC extends Bloc<AuthEvent, AuthState>{
  AuthBloC() : super(AuthInitialState()){
    on<LoginEvent>((event, emit) async{
      emit(AuthLoadingState());

      try{
       await  FirebaseAuth.instance.signInWithEmailAndPassword(email: event.email, password: event.password).then((value) {
          emit(AuthSuccessState());
        }).onError((error, stackTrace) {
          emit(AuthFailureState(errorMessage: error.toString()));
          _printErrorMsg('Sign in failed: ${error.toString()}');

        });
      }catch(e){
        emit(AuthFailureState(errorMessage: 'Login failed due to: ${e.toString()}'));
        _printErrorMsg(e.toString());
      }
    });

    on<SignupEvent> ((event, emit) async{
      emit(AuthLoadingState());

      try{
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: event.email, password: event.password).then((value) {
          emit(AuthSuccessState());
          debugPrint('Success emit');
        }).onError((error, stackTrace) {
          debugPrint('Error emit');
          emit(AuthFailureState(errorMessage: error.toString()));
          _printErrorMsg('Sign up failed: ${error.toString()}');

        });
      }catch(e){
        emit(AuthFailureState(errorMessage: 'Signup failed due to: ${e.toString()}'));
        debugPrint('Exception emit');
        _printErrorMsg(e.toString());
      }
    });
  }

  void _printErrorMsg(String msg){
    debugPrint('Error found: $msg');
  }
}