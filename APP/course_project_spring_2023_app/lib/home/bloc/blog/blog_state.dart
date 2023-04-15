part of 'blog_bloc.dart';

@immutable
class BlogState extends Equatable {
  BlogState({this.blogs = const <Blog>[], this.token = '', this.added = 0});

  late List<Blog> blogs;
  late String token;
  late int added = 0;

  BlogState copyWith({
    List<Blog>? blogs,
    String? token,
    int? added,
  }) {
    return BlogState(
      blogs: blogs ?? this.blogs,
      token: token ?? this.token,
      added: added ?? this.added,
    );
  }

  @override
  List<Object> get props => [blogs, token, added];
}

class Loading extends BlogState {}

class Loaded extends BlogState {
  Loaded(this.items);

  final List<Blog> items;
}

class Refresh extends BlogState {}
