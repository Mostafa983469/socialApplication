import 'dart:core';

class userModel{
  String? name;
  String? phone;
  String? email;
  String? id;
  String? bio;
  String? image;
  String? cover;

  userModel({
    this.name,
    this.phone,
    this.email,
    this.id,
    this.bio,
    this.image,
    this.cover,
  });

  userModel.fromJson(Map<String,dynamic>? json){
    name = json!['name'];
    phone = json['phone'];
    email = json['email'];
    id = json['id'];
    bio = json['bio'];
    image = json['image'];
    cover = json['cover'];
  }

  Map<String,dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'id': id,
      'bio': bio,
      'image': image,
      'cover': cover,
    };
  }

}