import 'dart:convert';
import 'package:eclipse_digital_studio_test/models/models.dart';
import 'package:eclipse_digital_studio_test/util/env.dart';

//Get users
class UserProvider {
  Future<List<User>> getUser() async {
    final responseUser = await dio.get('users');

    if (responseUser.statusCode == 200) {
      List<dynamic> responseUserJson = responseUser.data;

      return responseUserJson.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Error fetching users');
    }
  }
}

//Get user by id
class UserDetailProvider {
  Future<List<UserDetail>> getUserById(id) async {
    final responseUserDetail = await dio.get('users/$id');

    if (responseUserDetail.statusCode == 200) {
      List<dynamic> responseUserDetailJson = [];
      responseUserDetailJson.add(responseUserDetail.data);

      return responseUserDetailJson.map((json) => UserDetail.fromJson(json)).toList();
    } else {
      throw Exception('Error fetching users');
    }
  }
}

//Get posts by userId
class PostsProvider {
  Future<List<Posts>> getPosts(id) async {
    final responsePosts = await dio.get('users/$id/posts');

    if (responsePosts.statusCode == 200) {
      List<dynamic> responsePostsJson = responsePosts.data;
      preferences.setString('posts', jsonEncode(responsePosts.data));

      return responsePostsJson.map((json) => Posts.fromJson(json)).toList();
    } else {
      throw Exception('Error fetching users');
    }
  }
}

//Get albums by userId
class AlbumsProvider {
  Future<List<Albums>> getAlbums(id) async {
    final responseAlbums = await dio.get('users/$id/albums');

    if (responseAlbums.statusCode == 200) {
      List<dynamic> responseAlbumsJson = responseAlbums.data;

      return responseAlbumsJson.map((json) => Albums.fromJson(json)).toList();
    } else {
      throw Exception('Error fetching users');
    }
  }
}

//Get postDetail by postId
class PostDetailProvider {
  Future<List<PostDetail>> getPostDetail(postId) async {
    final responsePostDetail = await dio.get('posts/$postId/comments');

    if (responsePostDetail.statusCode == 200) {
      List<dynamic> responsePostDetailJson = responsePostDetail.data;

      return responsePostDetailJson.map((json) => PostDetail.fromJson(json)).toList();
    } else {
      throw Exception('Error fetching users');
    }
  }
}

//Get Album Detail by postId
class AlbumDetailProvider {
  Future<List<AlbumDetail>> getAlbumDetail(albumId) async {
    final responseAlbumDetail = await dio.get('albums/$albumId/photos');

    if (responseAlbumDetail.statusCode == 200) {
      List<dynamic> responseAlbumDetailJson = responseAlbumDetail.data;

      return responseAlbumDetailJson.map((json) => AlbumDetail.fromJson(json)).toList();
    } else {
      throw Exception('Error fetching users');
    }
  }
}
