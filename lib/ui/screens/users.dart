import 'dart:developer';

import 'package:eclipse_digital_studio_test/blocs/blocs.dart';
import 'package:eclipse_digital_studio_test/ui/screens/screens.dart';
import 'package:eclipse_digital_studio_test/util/env.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Users extends StatefulWidget {
  static const routeName = 'usersScreen';

  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  @override
  void initState() {
    //Sto Bloc
    final UserBloc userBloc = BlocProvider.of<UserBloc>(context);
    userBloc.add(UserLoadEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 15, right: 5, left: 5, bottom: 15),
          child: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
            if (state is UserLoadedState) {
              return ListView.builder(
                itemCount: state.loadedUser.length,
                itemBuilder: (BuildContext ctx, int index) {
                  var item = state.loadedUser[index];
                  return Card(
                    elevation: 1.0,
                    color: const Color(0xff14131B),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //UserName
                          Text(
                            item.username,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 10),
                          //Name
                          Text(
                            item.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              onPressed: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) => UserDetail(
                                      id: item.id,
                                      userName: item.username,
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.arrow_forward_rounded,
                                color: Colors.grey,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }

            if (state is UserLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return const Text('Ошибка соединения');
          }),
        ),
      ),
    );
  }
}
