part of 'rss_content_bloc.dart';

abstract class RssContentEvent extends Equatable {
  const RssContentEvent();
}

class RssContentFetched extends RssContentEvent {
  @override
  List<Object?> get props => [];
}

class RssContentRefreshed extends RssContentEvent {
  @override
  List<Object?> get props => [];
}
