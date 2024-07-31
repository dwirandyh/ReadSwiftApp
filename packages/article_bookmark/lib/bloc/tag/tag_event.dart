part of 'tag_bloc.dart';

abstract class TagEvent extends Equatable {
  const TagEvent();
}

final class TagUpdateList extends TagEvent {
  final List<Tag> tags;

  const TagUpdateList({required this.tags});

  @override
  List<Object?> get props => [tags];
}

class TagFetched extends TagEvent {
  @override
  List<Object?> get props => [];
}

class SelectedTagChanged extends TagEvent {
  final Tag? tag;

  const SelectedTagChanged({this.tag});

  @override
  List<Object?> get props => [tag];
}
