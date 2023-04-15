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

class BlogDeleted extends BlogEvent {
  BlogDeleted(this.blog);
  final Blog blog;
  @override
  List<Object> get props => [blog];
}

class BlogUpdated extends BlogEvent {
  BlogUpdated(this.blog);
  final Blog blog;
  @override
  List<Object> get props => [blog];
}

class BlogAdded extends BlogEvent {
  BlogAdded(this.blog);
  final Blog blog;
  @override
  List<Object> get props => [blog];
}
