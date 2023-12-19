part of 'tag_bloc.dart';

abstract class TagEvent extends Equatable {
  const TagEvent();
}

class TagFetched extends TagEvent {
  @override
  List<Object?> get props => [];
}

class SelectedTagChanged extends TagEvent {
  final Tag? tag;

  const SelectedTagChanged({this.tag});

  @override
  // TODO: implement props
  List<Object?> get props => [tag];
}
