import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/SocialCubit.dart';
import 'package:social_app/layout/cubit/SocialStates.dart';

class AddPostScreen extends StatelessWidget {
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'create post',
              ),
              actions:
              [
                TextButton(
                  onPressed: (){
                    var time = DateTime.now();
                    if(SocialCubit.get(context).postImage == null)
                      SocialCubit.get(context).addNewPost(text: textController.text, data: time.toString());
                    else
                      SocialCubit.get(context).addPostImage(text: textController.text, data: time.toString());
                  },
                  child: Text(
                    'Post',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
                SizedBox(
                  width: 15.0,
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  if(state is AddPostImageLoadingState)
                    LinearProgressIndicator(),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage('https://cdn.searchenginejournal.com/wp-content/uploads/2022/04/reverse-image-search-627b7e49986b0-sej-760x400.png'),
                        radius: 25.0,
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Text(
                        'Mostafa ahmed Ashour',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: textController,
                      decoration: InputDecoration(
                        hintText: 'what is in your mind ...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  if(SocialCubit.get(context).postImage != null)
                    Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children:
                    [
                      Container(
                        width: double.infinity,
                        height: 200.0,
                        child: Image(
                          fit: BoxFit.cover,
                          image: FileImage(SocialCubit.get(context).postImage!),
                        ),
                      ),
                       IconButton(
                            onPressed: (){
                              SocialCubit.get(context).removePostImage() ;
                            },
                            icon: Icon(Icons.close),
                        ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                            onPressed: (){
                              SocialCubit.get(context).getPostImage();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                    Icons.photo
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                    'add photo',
                                ),
                              ],
                            ),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: (){},
                          child: Text(
                            '# tags',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
    );
  }
}
