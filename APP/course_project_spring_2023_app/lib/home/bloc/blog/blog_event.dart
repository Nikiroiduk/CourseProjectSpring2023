part of 'blog_bloc.dart';

@immutable
abstract class BlogEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class _BlogsChanged extends BlogEvent {
  _BlogsChanged(this.blogs);

  final List<Blog> blogs;

  @override
  List<Object> get props => [blogs];
}

class TokenChanged extends BlogEvent {
  TokenChanged(this.token);

  final String token;

  @override
  List<Object> get props => [token];
}

class BlogsRefresh extends BlogEvent {
  BlogsRefresh();
}

class BlogsLoad extends BlogEvent {
  BlogsLoad();
}
