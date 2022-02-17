import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:eclipse_digital_studio_test/blocs/post_detail.dart';
import 'package:eclipse_digital_studio_test/ui/widgets/custom_textfield.dart';
import 'package:eclipse_digital_studio_test/util/env.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostDetail extends StatefulWidget {
  static const routeName = 'postDetailScreen';

  final dynamic postId;

  const PostDetail({Key? key, this.postId}) : super(key: key);

  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    //PostDetail Bloc
    final PostDetailBloc postDetailBloc = BlocProvider.of<PostDetailBloc>(context);
    postDetailBloc.add(PostDetailLoadEvent(widget.postId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Post Detail'),
          elevation: 0.0,
        ),
        body: SafeArea(
          child: BlocBuilder<PostDetailBloc, PostDetailState>(builder: (context, state) {
            if (state is PostDetailLoadedState) {
              return ListView.builder(
                itemCount: state.loadedPostDetail.length,
                itemBuilder: (BuildContext ctx, int index) {
                  var item = state.loadedPostDetail[index];
                  return Container(
                    margin: const EdgeInsets.only(top: 10, right: 10, bottom: 20, left: 10),
                    padding: const EdgeInsets.only(top: 10, right: 10, bottom: 20, left: 10),
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                          child: Text(
                            item.name,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                          child: Text(
                            item.email,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                          child: Text(
                            item.body,
                            style: const TextStyle(
                              color: Colors.white30,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
            if (state is PostDetailLoadingState) {
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
            ));
          }),
        ),
        bottomNavigationBar: InkWell(
          onTap: () {
            showModalBottomSheet<void>(
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return StatefulBuilder(
                  builder: (context, setState) {
                    return Container(
                      height: MediaQuery.of(context).size.height,
                      color: const Color(0xff0E0E12),
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Center(
                        child: Form(
                          key: _formKey,
                          child: ListView(
                            children: <Widget>[
                              const SizedBox(height: 50),
                              Align(
                                alignment: Alignment.topRight,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      child: const Text(
                                        'Закрыть',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      icon: const Icon(
                                        Icons.clear,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 30),
                              SizedBox(
                                height: 50,
                                child: CustomTextField(
                                  controller: nameController,
                                  hint: 'Имя',
                                  hintStyle: const TextStyle(
                                    color: Colors.white,
                                  ),
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return 'Заполните поле';
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                height: 50,
                                child: CustomTextField(
                                  controller: emailController,
                                  hint: 'Email',
                                  hintStyle: const TextStyle(
                                    color: Colors.white,
                                  ),
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return 'Заполните поле';
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                height: 50,
                                child: CustomTextField(
                                  controller: commentController,
                                  hint: 'Комментарий',
                                  hintStyle: const TextStyle(
                                    color: Colors.white,
                                  ),
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return 'Заполните поле';
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(height: 10),
                              InkWell(
                                onTap: () async {
                                  var record = {'userId': widget.postId, 'name': nameController.text, 'email': emailController.text, 'body': commentController.text};

                                  Response response;
                                  response = await dio.post('posts', data: record);

                                  if (_formKey.currentState!.validate()) {
                                    nameController.clear();
                                    emailController.clear();
                                    commentController.clear();
                                    Navigator.of(context).pop();
                                    db.put('newPosts', response.data);
                                  }
                                },
                                child: Container(
                                  height: 40,
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.all(Radius.circular(25)),
                                    gradient: LinearGradient(colors: [Colors.blue, Colors.purpleAccent]),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "Создать",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
          child: Container(
            height: 40,
            margin: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            decoration: const BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(25)),
              gradient: LinearGradient(colors: [Colors.blue, Colors.purpleAccent]),
            ),
            child: const Center(
              child: Text(
                "Отправить",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ));
  }
}
