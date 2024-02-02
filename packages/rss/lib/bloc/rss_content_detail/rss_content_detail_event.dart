part of 'rss_content_detail_bloc.dart';

abstract class RssContentDetailEvent extends Equatable {
  const RssContentDetailEvent();
}

class RssContentDetailFetched extends RssContentDetailEvent {
  @override
  List<Object?> get props => [];
}
