part of 'rss_content_bookmark_bloc.dart';

abstract class RssContentBookmarkState extends Equatable {
  const RssContentBookmarkState();
}

class RssContentBookmarkInitial extends RssContentBookmarkState {
  @override
  List<Object> get props => [];
}

class RssContentBookmarkAddSuccess extends RssContentBookmarkState {
  final String message;

  const RssContentBookmarkAddSuccess({required this.message});

  @override
  List<Object?> get props => [];
}

class RssContentBookmarkAddFailed extends RssContentBookmarkState {
  final String message;

  const RssContentBookmarkAddFailed({required this.message});

  @override
  List<Object?> get props => [];
}
