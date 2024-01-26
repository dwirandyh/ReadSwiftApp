part of 'rss_content_bloc.dart';

enum RssContentStatus { initial, loading, success, failure }

final class RssContentState extends Equatable {
  final RssContentStatus status;
  final List<RssContent> contents;
  final bool hasReachMax;
  const RssContentState({
    this.status = RssContentStatus.initial,
    this.contents = const <RssContent>[],
    this.hasReachMax = false,
  });

  RssContentState copyWith(
      {RssContentStatus? status,
      List<RssContent>? contents,
      bool? hasReachMax}) {
    return RssContentState(
      status: status ?? this.status,
      contents: contents ?? this.contents,
      hasReachMax: hasReachMax ?? this.hasReachMax,
    );
  }

  @override
  List<Object?> get props => [status, contents, hasReachMax];
}
