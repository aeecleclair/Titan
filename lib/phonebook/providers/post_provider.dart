import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/phonebook/class/post.dart';



final postProvider = StateNotifierProvider<PostProvider, Post>((ref) {
  return PostProvider();
});

class PostProvider extends StateNotifier<Post> {
PostProvider() : super(Post.empty());

  void setPost(Post i) {
    state = i;
  }
}