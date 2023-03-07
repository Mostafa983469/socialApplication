class addPost{
  String? name;
  String? id;
  String? text;
  String? image;
  String? postImage;
  String? data;

  addPost({
    this.name,
    this.id,
    this.text,
    this.image,
    this.postImage,
    this.data,
  });

  addPost.fromJson(Map<String,dynamic>? json){
    name = json!['name'];
    id = json['id'];
    text = json['text'];
    image = json['image'];
    postImage = json['postImage'];
    data = json['data'];
  }

  Map<String,dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'text': text,
      'image': image,
      'data' : data,
      'postImage': postImage,
    };
  }

}