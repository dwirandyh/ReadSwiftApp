part of 'manage_tag_bloc.dart';

@immutable
sealed class ManageTagEvent {}

final class ManageTagLoadTags extends ManageTagEvent {}

final class ManageTagDeleted extends ManageTagEvent {
  final int id;

  ManageTagDeleted({required this.id});
}
