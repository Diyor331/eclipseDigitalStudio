import 'package:eclipse_digital_studio_test/blocs/posts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'post_detail.dart';

class Posts extends StatefulWidget {
  static const routeName = 'postsScreen';
  final dynamic userId;

  const Posts({Key? key, this.userId}) : super(key: key);

  @override
  _PostsState createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  @override
  void initState() {
    //Posts Bloc
    final PostsBloc postsBloc = BlocProvider.of<PostsBloc>(context);
    postsBloc.add(PostsLoadEvent(widget.userId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
        elevation: 0.0,
      ),
      body: SafeArea(
        child: BlocBuilder<PostsBloc, PostsState>(builder: (context, state) {
          if (state is PostsLoadedState) {
            return ListView.builder(
              itemCount: state.loadedPosts.length,
              itemBuilder: (BuildContext ctx, int index) {
                var item = state.loadedPosts[index];
                return Container(
                  margin: const EdgeInsets.only(top: 10, right: 10, bottom: 10, left: 10),
                  padding: const EdgeInsets.only(top: 10, right: 10, bottom: 10, left: 10),
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Text(
                          item.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            item.body.toString().substring(0, item.body.toString().indexOf('\n')),
                            style: const TextStyle(
                              color: Colors.white30,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => PostDetail(postId: item.id),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }

          if (state is PostsLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return const Center(
            child: Text(
              'Ошибка соединения',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          );
        }),
      ),
    );
  }
}
