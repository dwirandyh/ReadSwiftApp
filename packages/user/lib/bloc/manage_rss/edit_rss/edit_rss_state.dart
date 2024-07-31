part of 'edit_rss_bloc.dart';

@immutable
sealed class EditRssState {}

final class EditRssInitial extends EditRssState {}

final class EditRssLoading extends EditRssState {}

final class EditRssFailed extends EditRssState {
  final String error;

  EditRssFailed({required this.error});
}

final class EditRssSuccess extends EditRssState {}
