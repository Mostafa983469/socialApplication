import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/SocialCubit.dart';
import 'package:social_app/layout/cubit/SocialStates.dart';
import 'package:social_app/models/addPost.dart';

class feedsScreen extends StatelessWidget {
  var commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
         listener: (context,state) {},
         builder: (context,state) {
           return ConditionalBuilder(
             condition: SocialCubit.get(context).posts.length > 0 ,
             builder: (context) => SingleChildScrollView(
               physics: BouncingScrollPhysics(),
               child: Padding(
                 padding: const EdgeInsetsDirectional.all(5.0),
                 child: Column(
                   children:
                   [
                     Stack(
                     alignment: AlignmentDirectional.bottomEnd,
                     children: [
                       Image(
                         width: double.infinity,
                         height: 200.0,
                         fit: BoxFit.cover,
                         image: NetworkImage('https://wallpapershome.com/images/pages/pic_h/21486.jpg'),
                       ),
                       Padding(
                         padding: const EdgeInsetsDirectional.all(10.0),
                         child :Text(
                           'hallo in our project Communicate with friends',
                           style: Theme.of(context).textTheme.bodyText1,
                         ),),
                     ],
                   ),
                     SizedBox(
                     height: 10.0,
                   ),
                     ListView.separated(
                       physics: NeverScrollableScrollPhysics(),
                       shrinkWrap: true,
                       itemBuilder: (context,index) => BuildItem(SocialCubit.get(context).posts[index],context,index),
                       separatorBuilder: (BuildContext context, int index) => Container(
                         height: 2.0,
                         width: double.infinity,
                         color: Colors.grey,
                       ),
                       itemCount: SocialCubit.get(context).posts.length, 
                     ),
                   ],
                 ),
               ),
             ),
             fallback: (context) => const Center(child: CircularProgressIndicator()),
           );
         },
     );

  }
  Widget BuildItem(addPost model ,context, index) => Container(
    child: Padding(
      padding: const EdgeInsets.all(7.0),
      child : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage('${model.image}'),
                radius: 25.0,
              ),
              SizedBox(
                width: 20.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                [
                  Row(
                    children: [
                      Text(
                        '${model.name}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      CircleAvatar(
                        radius: 9.0,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.check_circle,
                          color: Colors.blue,
                          size: 18.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3.0,
                  ),
                  Text(
                    '${model.data}',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
              Spacer(),
              IconButton(
                onPressed: (){},
                icon: Icon(
                  Icons.more_horiz,
                  size: 15,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15.0,
          ),
          Text(
            '${model.text}',
            style: Theme.of(context).textTheme.bodyText2,
          ),
         /* Wrap(
            children:
            [
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 5.0),
                child: Container(
                  height: 25.0,
                  child: MaterialButton(
                    padding: EdgeInsets.zero,
                    minWidth: 1,
                    onPressed: (){},
                    child: Text(
                      '#mostafa',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                          color: Colors.blue
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 5.0),
                child: Container(
                  height: 25.0,
                  child: MaterialButton(
                    padding: EdgeInsets.zero,
                    minWidth: 1,
                    onPressed: (){},
                    child: Text(
                      '#mostafa',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                          color: Colors.blue
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),*/
         if(model.postImage != '')
            Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Image(
              width: double.infinity,
              height: 250.0,
              fit: BoxFit.cover,
              image: NetworkImage('${model.postImage}'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 12.0
            ),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      InkWell(
                        child: Icon(
                          Icons.favorite_border,
                          size: 16,
                        ),
                        onTap: (){},
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        '${SocialCubit.get(context).likes[index]}',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        child: Icon(
                          Icons.comment,
                          size: 16,
                        ),
                        onTap: (){},
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        '${SocialCubit.get(context).comments[index]} comments',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage('${SocialCubit.get(context).model.image}'),
                radius: 20.0,
              ),
              SizedBox(
                width: 10.0,
              ),
                Expanded(
                  child: TextFormField(
                    controller: commentController,
                    decoration: InputDecoration(
                      hintText: 'write your comment ...',
                      border: InputBorder.none,
                    ),
                    onEditingComplete: (){
                      SocialCubit.get(context).comment(
                          SocialCubit.get(context).postId[index],
                          commentController.text);
                      commentController.text = '';
                    },
                  ),
                ),
                /*Text(
                  'write a comment .... ',
                  style: Theme.of(context).textTheme.caption,
                ),*/
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      child: Icon(
                        Icons.favorite_border,
                        size: 16,
                      ),
                      onTap: (){
                        SocialCubit.get(context).likePost(SocialCubit.get(context).postId[index]);
                      },
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      'Like',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}