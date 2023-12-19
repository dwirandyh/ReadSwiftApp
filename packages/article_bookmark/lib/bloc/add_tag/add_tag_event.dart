part of 'add_tag_bloc.dart';

abstract class AddTagEvent extends Equatable {
  const AddTagEvent();
}

class AddTagRequested extends AddTagEvent {
  final String tag;

  const AddTagRequested({required this.tag});

  @override
  List<Object?> get props => [tag];
}
