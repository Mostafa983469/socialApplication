import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/sharred/network/local/sharred.dart';
import 'loginstate.dart';

class LoginCubit extends Cubit<LoginStates>{

  LoginCubit() : super(IntilState());
  
  static LoginCubit get(context) => BlocProvider.of(context);

  void Login({required String email, required String password,})
  {
    emit(loadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword
      (
        email: email,
        password: password
    ).then((value) {
        emit(LoginSucessState(value.user!.uid));
    }).catchError((Error) {
      emit(LoginErrorState());
    });
  }

  bool IsPassword = true;
  IconData icon = Icons.visibility_outlined;
  void ChangeVisiplitiy(){
    IsPassword = ! IsPassword;
    icon = IsPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined ;
    emit(ChangePasswordVisibilityState());
  }
}