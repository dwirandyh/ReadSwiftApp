part of 'rss_content_bookmark_bloc.dart';

abstract class RssContentBookmarkEvent extends Equatable {
  const RssContentBookmarkEvent();
}

class RssContentBookmarkAdded extends RssContentBookmarkEvent {
  final int contentId;

  const RssContentBookmarkAdded({required this.contentId});

  @override
  List<Object?> get props => [];
}
