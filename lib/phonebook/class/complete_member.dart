import 'package:myecl/phonebook/class/post.dart';
import 'member.dart';

class CompleteMember{
  CompleteMember({
    required this.member,
    required this.post,
  });

  late final Member member;
  late final List<Post> post;
  

  CompleteMember.fromJSON(Map<String, dynamic> json){
      member = Member.fromJSON(json['user']);
      post = json['post'].map((post) => Post.fromJSON(post)).toList();
      }
    
  Map<String, dynamic> toJSON(){
    final data = <String, dynamic>{
      'member': member.id,
      'post': post.map((e) => [e.association.id, e.role.id]),
    };
    return data;
  }

  CompleteMember copyWith({
    Member? member,
    List<Post>? post,
  }) {
    return CompleteMember(
      member: member ?? this.member,
      post: post ?? this.post,
    );
  }

  CompleteMember.empty(){
    member = Member.empty();
    post = [];
  }

}  
