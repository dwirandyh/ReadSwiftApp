part of 'edit_rss_bloc.dart';

@immutable
sealed class EditRssEvent {}

class EditRssRequested extends EditRssEvent {
  final String? name;
  final String url;

  EditRssRequested({required this.name, required this.url});
}
