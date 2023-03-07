import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/layout/cubit/SocialStates.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/addPost.dart';
import 'package:social_app/models/massage.dart';
import 'package:social_app/models/users.dart';
import 'package:social_app/modules/feeds/feeds_screen.dart';

import '../../modules/add_post/addPost_screen.dart';
import '../../modules/chats/chat_screen.dart';
import '../../modules/editProfile/edit_profile.dart';
import '../../modules/settings/settings_screen.dart';
import '../../sharred/components/constans.dart';


class SocialCubit extends Cubit<SocialStates>{

  SocialCubit() : super(InitialState());
  
  static SocialCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  late userModel model ;
  List<Widget> screens = [feedsScreen(),chatsScreen(),AddPostScreen(),settingsScreen(),editProfileScreen()];
  List<String> titles = ['feeds', 'chats','add', 'user', 'edit'];

  void getUserData(){
    emit(GetUserLoadingState());
    FirebaseFirestore.instance.collection('user')
        .doc(id).get()
        .then((value) {
          model = userModel.fromJson(value.data());
          emit(GetUserSuccessState());
    })
        .catchError((error) {
      emit(GetUserErrorState());
    });
  }

  void changeIndex(int index){
   if(index != 2){
     currentIndex = index ;
     emit(ChangeBottomNavState());
   }else {
     emit(AddPostPageState());
   }
  }
  var picker = ImagePicker();

   File? profileImage;

  Future updateProfileImage() async {
      final pikedFile = await picker.pickImage(source: ImageSource.gallery);
      if(pikedFile != null){
        profileImage = File(pikedFile.path);
        emit(ChangeProfileSuccessState());
      }else{
        emit(ChangeProfileErrorState());
      }

  }

  File? coverImage;

  Future updateCoverImage() async {
    final pikedFile = await picker.pickImage(source: ImageSource.gallery);
    if(pikedFile != null){
      coverImage = File(pikedFile.path);
      emit(ChangeProfileSuccessState());
    }else{
      emit(ChangeProfileErrorState());
    }
  }

  /*String profileImageUrl = '' ;
  String coverImageUrl = '' ;
*/
  void uploadProfileImage({
    required String name,
    required String bio,
    required String phone,
  }){
    FirebaseStorage.instance.
      ref()
        .child('user/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
          value.ref.getDownloadURL()
              .then((value) {
                update(
                    name: name,
                    bio: bio,
                    phone: phone,
                    image: value,
                );
                profileImage = null ;
                emit(UploadProfileSuccessState());
          }).catchError((error) {
            emit(UploadProfileErrorState());
          });
        })
        .catchError(
            (error) {
              emit(UploadProfileErrorState());
            });
  }

  void uploadCoverImage({
    required String name,
    required String bio,
    required String phone,
  }
  ){
    FirebaseStorage.instance.
    ref()
        .child('user/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL()
          .then((value) {
        update(
          name: name,
          bio: bio,
          phone: phone,
          cover: value,
        );
        emit(UploadCoverSuccessState());
        coverImage = null ;
      }).catchError((error) {
        emit(UploadCoverErrorState());
      });
    })
        .catchError(
            (error) {
          emit(UploadCoverErrorState());
        });
  }

  void update(
      {
        required String name ,
        required String bio ,
        required String phone ,
        String? cover,
        String? image,
      }
      )
  {
    userModel newModel = userModel(
      name: name,
      bio: bio,
      phone: phone,
      cover: cover??model.cover,
      image: image??model.image,
      id: model.id,
      email: model.email,
    );
    FirebaseFirestore.instance
        .collection('user')
        .doc(model.id)
        .update(newModel.toMap())
        .then((value) {
      getUserData();
    }).catchError((error){
      emit(UpdateUserErrorState());
    });
  }

  File? postImage;

  Future getPostImage() async {
    final pikedFile = await picker.pickImage(source: ImageSource.gallery);
    if(pikedFile != null){
      postImage = File(pikedFile.path);
      emit(AddPostImageSuccessState());
    }else{
      emit(AddPostImageErrorState());
    }

  }

  void removePostImage(){
    postImage = null;
    emit(RemovePostImageSuccessState());
  }
  void addPostImage({
    required String text,
    required String data,
  }
      ){
    emit(AddPostImageLoadingState());
    FirebaseStorage.instance.
    ref()
        .child('user/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL()
          .then((value) {
        addNewPost(
          text: text,
          data: data,
          postImage: value,
        );
        emit(AddPostImageSuccessState());
      }).catchError((error) {
        emit(AddPostImageErrorState());
      });
    })
        .catchError(
            (error) {
              emit(AddPostImageErrorState());
        });
  }

  void addNewPost(
      {
        required String? text,
        String? postImage,
        required String? data,
      }
      )
  {
    addPost post = addPost(
      name: model.name,
      text: text,
      id: model.id,
      image: model.image,
      data: data,
      postImage: postImage??'',
    );
    FirebaseFirestore.instance
        .collection('post')
        .add(post.toMap())
        .then((value) {

    }).catchError((error){
      emit(UpdateUserErrorState());
    });
  }

  List<addPost> posts = [];
  List<String> postId = [];
  List<int> likes = [];
  List<int> comments = [];

  void getPost(){
    emit(GetPostsLoadingState());
    FirebaseFirestore.instance
        .collection('post')
        .get()
        .then((value) {
          value.docs.forEach((element) {
            element.reference.collection('comments').get().then((value) {
              comments.add(value.docs.length);
            }).catchError((error) {
            });
            element.reference
                .collection('likes')
                .get().then((value) {
                  likes.add(value.docs.length);
                  postId.add(element.id);
                  posts.add(addPost.fromJson(element.data()));
            }).catchError((error) {
              emit(GetPostsErrorState());
            });
          });
          emit(GetPostsSuccessState());
    })
        .catchError((error){
          emit(GetPostsErrorState());
    });
  }

  void likePost(var postId){
    FirebaseFirestore.instance
        .collection('post')
        .doc(postId)
        .collection('likes')
        .doc(model.id)
        .set({
      'like' : true,
    })
        .then((value) {
      emit(GetLikeSuccessState());
    }).catchError((error) {
      emit(GetLikesErrorState());
    });
  }

  void comment(var postId, text){
    FirebaseFirestore.instance
        .collection('post')
        .doc(postId)
        .collection('comments')
        .add(
      {
        'comment' : text,
      }
    )
        .then((value) {
      emit(CommentSuccessState());
    }).catchError((error) {
      emit(CommentErrorState());
    });
  }

  List<userModel> users = [];

  void getUsers(){
    emit(GetPostsLoadingState());
    FirebaseFirestore.instance
        .collection('user')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        if(element.data()['id'] != model.id)
          users.add(userModel.fromJson(element.data()));

      });
      emit(GetUsersSuccessState());
    })
        .catchError((error){
      emit(GetUsersErrorState());
    });
    }

  void sendMassage({
    required String data,
    required String text,
    required String receiverId,
})
  {
    Massage massage = Massage(
      data: data,
      senderId : model.id,
      receiverID: receiverId,
      text: text,
    );

    FirebaseFirestore.instance
    .collection('user')
    .doc(model.id).collection('chat')
        .doc(receiverId).collection('massage').add(massage.toMap())
        .then((value) {
      emit(SendMassageSuccessState());
    }).catchError((error) {
      emit(SendMassageErrorState());
    });

    FirebaseFirestore.instance
        .collection('user')
        .doc(receiverId).collection('chat')
        .doc(model.id).collection('massage').add(massage.toMap())
        .then((value) {
      emit(SendMassageSuccessState());
    }).catchError((error) {
      emit(SendMassageErrorState());
    });

  }
  List<Massage> massages = [];

  void GetMassage({
  required String receiverId
}){
    FirebaseFirestore.instance
        .collection('user').doc(model.id)
        .collection('chat').doc(receiverId).collection('massage').orderBy('data')
        .snapshots()
        .listen((event) {
          massages = [];
          event.docs.forEach((element) { 
            massages.add(Massage.fromJson(element.data()));
          });
          emit(GetMassageSuccessState());
    });
  }

  }
