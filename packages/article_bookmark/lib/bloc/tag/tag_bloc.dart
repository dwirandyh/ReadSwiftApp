import 'package:article_bookmark/model/tag.dart';
import 'package:article_bookmark/repository/tag_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tag_event.dart';
part 'tag_state.dart';

class TagBloc extends Bloc<TagEvent, TagState> {
  final TagRepository tagRepository;
  int page = 1;

  TagBloc({required this.tagRepository})
      : super(TagState(selectedTag: Tag.all())) {
    on<TagFetched>(_onTagFetched);
    on<SelectedTagChanged>(_onSelectedTagChanged);
  }

  Future<void> _onTagFetched(TagFetched event, Emitter<TagState> emit) async {
    try {
      List<Tag> tags = await tagRepository.fetchTag(page: page);
      emit(state.copyWith(tags: tags, status: TagStatus.success));
    } catch (_) {
      emit(state.copyWith(status: TagStatus.error));
    }
  }

  Future<void> _onSelectedTagChanged(
      SelectedTagChanged event, Emitter<TagState> emit) async {
    emit(state.copyWith(selectedTag: event.tag));
  }
}
