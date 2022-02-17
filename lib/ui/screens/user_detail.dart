import 'dart:convert';
import 'dart:developer';

import 'package:eclipse_digital_studio_test/blocs/blocs.dart';
import 'package:eclipse_digital_studio_test/ui/screens/screens.dart';
import 'package:eclipse_digital_studio_test/util/env.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserDetail extends StatefulWidget {
  static const routeName = 'userDetailScreen';
  final dynamic id;
  final dynamic userName;

  const UserDetail({Key? key, this.userName, this.id}) : super(key: key);

  @override
  _UserDetailState createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  @override
  void initState() {
    //UserDetail Bloc
    final UserDetailBloc userDetailBloc = BlocProvider.of<UserDetailBloc>(context);
    userDetailBloc.add(UserDetailLoadEvent(widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(widget.userName),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 15),
          child: BlocBuilder<UserDetailBloc, UserDetailState>(builder: (context, state) {
            if (state is UserDetailLoadedState) {
              return ListView.builder(
                itemCount: state.loadedUserDetail.length,
                itemBuilder: (BuildContext ctx, int index) {
                  var item = state.loadedUserDetail[index];
                  return Column(
                    children: [
                      //User Info
                      Container(
                        decoration: const BoxDecoration(
                          color: Color(0xff14131B),
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //Avatar
                                  const Expanded(
                                    child: CircleAvatar(
                                      radius: 60,
                                      backgroundColor: Colors.black54,
                                      child: Icon(Icons.person_pin_rounded, size: 60, color: Colors.white),
                                    ),
                                  ),
                                  //Name,phone,email,website
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        //Name and Username
                                        Text(
                                          '${item.name} ${item.username}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        //Email
                                        RichText(
                                          text: TextSpan(
                                            text: 'Email: ',
                                            style: const TextStyle(
                                              color: Color(0xffB0B3B8),
                                              fontSize: 15,
                                              fontFamily: 'Montserrat',
                                            ),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: item.email,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Montserrat',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        //Phone
                                        RichText(
                                          text: TextSpan(
                                            text: 'Phone: ',
                                            style: const TextStyle(
                                              color: Color(0xffB0B3B8),
                                              fontSize: 15,
                                              fontFamily: 'Montserrat',
                                            ),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: item.phone,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Montserrat',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        //Website
                                        RichText(
                                          text: TextSpan(
                                            text: 'Website: ',
                                            style: const TextStyle(
                                              color: Color(0xffB0B3B8),
                                              fontSize: 15,
                                              fontFamily: 'Montserrat',
                                            ),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: item.website,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Montserrat',
                                                  decoration: TextDecoration.underline,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              //Address
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Address:',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'Street: ${item.address['street']}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'Suite: ${item.address['suite']}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'City: ${item.address['city']}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'Zipcode: ${item.address['zipcode']}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              //Company
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Center(
                                    child: Text(
                                      'Company:',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'Name: ${item.company['name']}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'Bs: ${item.company['bs']}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      '${item.company['catchPhrase']}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 16,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 30),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      //Posts
                      const Center(
                        child: Text(
                          'Posts',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 6,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 3,
                          itemBuilder: (BuildContext ctx, int index) {
                            var item = state.loadedPosts[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width / 1.3,
                                margin: const EdgeInsets.only(right: 10),
                                decoration: const BoxDecoration(
                                  color: Color(0xff14131B),
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                      color:  Colors.white30,
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(0, 0), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        item.title,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          item.body.toString().substring(0, item.body.toString().indexOf('\n')),
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      //'Посмотреть все'
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => Posts(userId: widget.id,),
                            ),
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(top: 10,right: 5),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Text('Просмотреть все',style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      //Albums
                      const Center(
                        child: Text(
                          'Albums',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 7,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 3,
                          itemBuilder: (BuildContext ctx, int index) {
                            var item = state.loadedAlbums[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width / 2,
                                margin: const EdgeInsets.only(right: 10),
                                decoration: const BoxDecoration(
                                  color: Color(0xff14131B),
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                      color:  Colors.white30,                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(0, 0), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:  [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        item.title,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      //'Посмотреть все'
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => Albums(userId: widget.id),
                            ),
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(top: 10,right: 5),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Text('Просмотреть все',style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  );
                },
              );
            }

            if (state is UserDetailLoadingState) {
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

