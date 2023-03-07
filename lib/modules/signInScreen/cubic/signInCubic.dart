import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/users.dart';
import 'package:social_app/modules/signInScreen/cubic/signInStates.dart';



class SignInCubit extends Cubit<SignInStates>{

  SignInCubit() : super(SignInIntilState());
  
  static SignInCubit get(context) => BlocProvider.of(context);

  late userModel model;

  void SignIn(
      {
        required String email,
        required String password,
        required String name,
        required String phone,
      }
      )
  {
    emit(SignInLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword
      (
        email: email,
        password: password
    ).then((value) {
      createUser(email: email, id: value.user!.uid, name: name, phone: phone);
    }).catchError((error) {
      emit(SignInErrorState());
    });
  }

  createUser(
      {
        required String email,
        required String id,
        required String name,
        required String phone,
        String bio = 'bio',
        String image = 'https://cdn.searchenginejournal.com/wp-content/uploads/2022/04/reverse-image-search-627b7e49986b0-sej-760x400.png',
        String cover = 'https://wallpapershome.com/images/pages/pic_h/21486.jpg',
      }
      ){
    emit(LoadingCreateUserState());
    model = userModel(
        email : email,
        id : id,
        phone : phone,
        name : name,
        cover: cover,
        bio: bio,
        image: image,
    );
    FirebaseFirestore.instance.collection('user')
        .doc(id).set(model.toMap())
        .then((value) {
          emit(SucessCreateUserState(id));
          emit(SignInSucessState());
    })
        .catchError(((error){
          emit(ErrorCreateUserState());
    }));
  }


  bool IsPassword = true;
  IconData icon = Icons.visibility_outlined;
  void ChangeVisiplitiy(){
    IsPassword = ! IsPassword;
    icon = IsPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined ;
    emit(ChangePasswordSignInVisibilityState());
  }
}