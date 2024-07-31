import 'dart:async';

import 'package:article_bookmark/repository/tag_repository.dart';
import 'package:article_bookmark_api/article_bookmark_api.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tag_event.dart';
part 'tag_state.dart';

class TagBloc extends Bloc<TagEvent, TagState> {
  final TagRepository tagRepository;
  late final StreamSubscription<List<Tag>> _tagSubscription;

  TagBloc({required this.tagRepository})
      : super(TagState(selectedTag: Tag.all())) {
    on<TagFetched>(_onTagFetched);
    on<SelectedTagChanged>(_onSelectedTagChanged);
    on<TagUpdateList>(onTagUpdateList);

    _tagSubscription = tagRepository.tags.listen((data) {
      add(TagUpdateList(tags: data));
    });
  }

  Future<void> _onTagFetched(TagFetched event, Emitter<TagState> emit) async {
    try {
      await tagRepository.fetchTag();
    } catch (_) {
      emit(state.copyWith(status: TagStatus.error));
    }
  }

  void _onSelectedTagChanged(
      SelectedTagChanged event, Emitter<TagState> emit) async {
    emit(state.copyWith(selectedTag: event.tag));
  }

  void onTagUpdateList(TagUpdateList event, Emitter<TagState> emit) {
    emit(state.copyWith(tags: event.tags, status: TagStatus.success));
  }
}
