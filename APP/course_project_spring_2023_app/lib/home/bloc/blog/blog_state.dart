part of 'blog_bloc.dart';

@immutable
class BlogState extends Equatable {
  BlogState({this.blogs = const <Blog>[], this.token = ''});

  late List<Blog> blogs;
  late String token;

  BlogState copyWith({
    List<Blog>? blogs,
    String? token,
  }) {
    return BlogState(
      blogs: blogs ?? this.blogs,
      token: token ?? this.token,
    );
  }

  @override
  List<Object> get props => [blogs, token];
}

class Loading extends BlogState {}

class Loaded extends BlogState {
  Loaded(this.items);

  final List<Blog> items;
}

class Refresh extends BlogState {}
