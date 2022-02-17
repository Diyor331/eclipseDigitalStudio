//Получение историй заявок клиента
import 'dart:developer';

import 'package:eclipse_digital_studio_test/models/models.dart';
import 'package:eclipse_digital_studio_test/services/providers.dart';

//User to repo
class UserRepository {
  final UserProvider _userProvider = UserProvider();

  Future<List<User>> getAllUsers() {
    return _userProvider.getUser();
  }
}

//User by id to repo
class UserDetailRepository {
  final UserDetailProvider _userDetailProvider = UserDetailProvider();

  Future<List<UserDetail>> getUserById(id) {
    return _userDetailProvider.getUserById(id);
  }
}

//Posts by userId
class PostsRepository {
  final PostsProvider _postsProvider = PostsProvider();

  Future<List<Posts>> getPosts(userId) {
    return _postsProvider.getPosts(userId);
  }
}

//Albums by userId
class AlbumsRepository {
  final AlbumsProvider _albumsProvider = AlbumsProvider();

  Future<List<Albums>> getAlbums(userId) {
    return _albumsProvider.getAlbums(userId);
  }
}

//PostDetail by postId
class PostDetailRepository {
  final PostDetailProvider _postDetailProvider = PostDetailProvider();

  Future<List<PostDetail>> getPostDetail(postId) {
    return _postDetailProvider.getPostDetail(postId);
  }
}

//AlbumDetail by postId
class AlbumDetailRepository {
  final AlbumDetailProvider _albumDetailProvider = AlbumDetailProvider();

  Future<List<AlbumDetail>> getAlbumDetail(albumId) {
    return _albumDetailProvider.getAlbumDetail(albumId);
  }
}
