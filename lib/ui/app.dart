import 'package:eclipse_digital_studio_test/blocs/blocs.dart';
import 'package:eclipse_digital_studio_test/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'screens/screens.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(create: (context) => UserBloc(UserRepository())),
        BlocProvider<UserDetailBloc>(create: (context) => UserDetailBloc(UserDetailRepository(), PostsRepository(), AlbumsRepository())),
        BlocProvider<PostsBloc>(create: (context) => PostsBloc(PostsRepository())),
        BlocProvider<AlbumsBloc>(create: (context) => AlbumsBloc(AlbumsRepository())),
        BlocProvider<PostDetailBloc>(create: (context) => PostDetailBloc(PostDetailRepository())),
        BlocProvider<AlbumDetailBloc>(create: (context) => AlbumDetailBloc(AlbumDetailRepository())),
      ],
      child: MaterialApp(
        title: 'Eclipse Digital Studio',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xff0E0E12),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xff14131B),
          ),
          fontFamily: 'Montserrat',
          primarySwatch: Colors.blue,
        ),
        initialRoute: Splash.routeName,
        routes: {
          Splash.routeName: (context) => Splash(),
          Users.routeName: (context) => Users(),
          UserDetail.routeName: (context) => const UserDetail(),
          Posts.routeName: (context) => Posts(),
          Albums.routeName: (context) => Albums(),
          PostDetail.routeName: (context) => PostDetail(),
          AlbumDetail.routeName: (context) => AlbumDetail(),
        },
      ),
    );
  }
}
