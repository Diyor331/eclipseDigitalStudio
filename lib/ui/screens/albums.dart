import 'dart:developer';

import 'package:eclipse_digital_studio_test/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'album_detail.dart';

class Albums extends StatefulWidget {
  static const routeName = 'albumsScreen';

  final dynamic userId;

  const Albums({Key? key, this.userId}) : super(key: key);

  @override
  _AlbumsState createState() => _AlbumsState();
}

class _AlbumsState extends State<Albums> {
  @override
  void initState() {
    //Albums Bloc
    final AlbumsBloc albumsBloc = BlocProvider.of<AlbumsBloc>(context);
    albumsBloc.add(AlbumsLoadEvent(widget.userId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Albums'),
        elevation: 0.0,
      ),
      body: SafeArea(
        child: BlocBuilder<AlbumsBloc, AlbumsState>(builder: (context, state) {
          if (state is AlbumsLoadedState) {
            return ListView.builder(
                itemCount: state.loadedAlbums.length,
                itemBuilder: (BuildContext ctx, int index) {
                  var item = state.loadedAlbums[index];
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
                          leading: Text(
                            '${index + 1}',
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => AlbumDetail(albumId:item.id),
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
                });
          }
          if (state is AlbumsLoadingState) {
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
