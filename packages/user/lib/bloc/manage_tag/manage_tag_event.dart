part of 'manage_tag_bloc.dart';

@immutable
sealed class ManageTagEvent {}

final class ManageTagLoadTags extends ManageTagEvent {}

final class ManageTagDelete extends ManageTagEvent {
  final int id;

  ManageTagDelete({required this.id});
}

final class ManageTagRename extends ManageTagEvent {
  final int id;
  final String newName;

  ManageTagRename({required this.id, required this.newName});
}

final class ManageTagUpdateOrder extends ManageTagEvent {
  final int oldIndex;
  final int newIndex;

  ManageTagUpdateOrder({required this.oldIndex, required this.newIndex});
}
