part of 'rss_content_detail_bloc.dart';

sealed class RssContentDetailState extends Equatable {
  const RssContentDetailState();
}

class RssContentDetailLoading extends RssContentDetailState {
  @override
  List<Object?> get props => [];
}

class RssContentDetailSuccess extends RssContentDetailState {
  final RssContent content;

  const RssContentDetailSuccess({required this.content});

  @override
  List<Object?> get props => [content];
}

class RssContentDetailFailed extends RssContentDetailState {
  @override
  List<Object?> get props => [];
}
