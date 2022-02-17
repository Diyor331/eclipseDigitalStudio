import 'dart:convert';
import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:eclipse_digital_studio_test/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlbumDetail extends StatefulWidget {
  static const routeName = 'albumDetailScreen';
  final dynamic albumId;

  const AlbumDetail({Key? key, this.albumId}) : super(key: key);

  @override
  _AlbumDetailState createState() => _AlbumDetailState();
}

class _AlbumDetailState extends State<AlbumDetail> {
  @override
  void initState() {
    //AlbumDetail Bloc
    final AlbumDetailBloc albumDetailBloc = BlocProvider.of<AlbumDetailBloc>(context);
    albumDetailBloc.add(AlbumDetailLoadEvent(widget.albumId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text('Album Detail'),
      ),
      body: SafeArea(
        child: BlocBuilder<AlbumDetailBloc, AlbumDetailState>(builder: (context, state) {
          if (state is AlbumDetailLoadedState) {
            return ListView.builder(
                itemCount: state.loadedAlbumDetail.length,
                itemBuilder: (BuildContext ctx, int index) {
                  var item = state.loadedAlbumDetail[index];

                  List imgList = [];

                  for (var el in state.loadedAlbumDetail) {
                    if (item.id == el.id) {
                      imgList.add(el.url);
                      imgList.add(el.thumbnailUrl);
                    }
                  }


                  return Container(
                    margin: const EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
                    padding: const EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        CarouselSlider.builder(
                          itemCount: imgList.length,
                          itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
                            var itemImg = imgList[itemIndex];
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Image.network(itemImg),
                            );
                          },
                          options: CarouselOptions(
                            height: 400,
                            onPageChanged: (index, reason) {
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                });
          }
          if (state is AlbumDetailLoadingState) {
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
