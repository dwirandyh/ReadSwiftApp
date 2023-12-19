part of 'add_tag_bloc.dart';

abstract class AddTagState extends Equatable {
  const AddTagState();
}

class AddTagInitial extends AddTagState {
  @override
  List<Object?> get props => [];
}

class AddTagSuccess extends AddTagState {
  @override
  List<Object> get props => [];
}

class AddTagError extends AddTagState {
  final String error;

  const AddTagError({required this.error});

  @override
  List<Object?> get props => [error];
}
