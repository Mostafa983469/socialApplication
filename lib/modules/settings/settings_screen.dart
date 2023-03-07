import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/SocialCubit.dart';
import 'package:social_app/layout/cubit/SocialStates.dart';

class settingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return   BlocConsumer<SocialCubit,SocialStates>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Container(
                    height: 250.0,
                    child :Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                            bottom: 50.0,
                          ),
                          child: Image(
                            width: double.infinity,
                            height: 200.0,
                            fit: BoxFit.cover,
                            image: NetworkImage('${SocialCubit.get(context).model.cover}'),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsetsDirectional.only(
                              top: 25.0,
                            ),
                            child : CircleAvatar(
                              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                              radius: 64.0,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage('${SocialCubit.get(context).model.image}'),
                                radius: 60.0,
                              ),
                            )
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Text(
                    '${SocialCubit.get(context).model.name}',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    '${SocialCubit.get(context).model.bio}',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              '100',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              'posts',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              '100',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              'photo',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              '100',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              'followers',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              '100',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              'following',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
          listener: (context, state) {},
        );
  }
}
