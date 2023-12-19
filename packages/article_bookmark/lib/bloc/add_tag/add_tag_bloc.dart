import 'dart:async';

import 'package:article_bookmark/repository/tag_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_tag_event.dart';
part 'add_tag_state.dart';

class AddTagBloc extends Bloc<AddTagEvent, AddTagState> {
  final TagRepository tagRepository;

  AddTagBloc({required this.tagRepository}) : super(AddTagInitial()) {
    on<AddTagRequested>(_onAddTagRequested);
  }

  Future<void> _onAddTagRequested(
      AddTagRequested event, Emitter<AddTagState> emit) async {
    try {
      await tagRepository.addTag(tag: event.tag);
      emit(AddTagSuccess());
    } catch (_) {
      emit(const AddTagError(
          error: "Failed to create new tag, please try again later"));
    }
  }
}
