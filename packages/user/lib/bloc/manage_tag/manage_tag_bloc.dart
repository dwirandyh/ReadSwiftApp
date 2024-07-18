import 'package:article_bookmark_api/article_bookmark_api.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'manage_tag_event.dart';
part 'manage_tag_state.dart';

class ManageTagBloc extends Bloc<ManageTagEvent, ManageTagState> {
  final TagRepositoryApi tagRepository;
  ManageTagBloc({required this.tagRepository})
      : super(ManageTagState.initial()) {
    on<ManageTagLoadTags>(_onManageTagLoadTags);
    on<ManageTagDelete>(_onManageTagDeleted);
    on<ManageTagRename>(_onManageTagRename);
  }

  void _onManageTagLoadTags(
      ManageTagLoadTags event, Emitter<ManageTagState> emit) async {
    emit(state.copyWith(status: ManageTagStatus.loading));
    try {
      final tags = await tagRepository.fetchTag(page: 1);
      emit(state.copyWith(status: ManageTagStatus.loaded, tags: List.of(tags)));
    } catch (e) {
      emit(state.copyWith(status: ManageTagStatus.error));
    }
  }

  void _onManageTagDeleted(
      ManageTagDelete event, Emitter<ManageTagState> emit) async {
    try {
      await tagRepository.deleteTag(id: event.id);
      final List<Tag> updatedTags = state.tags;
      updatedTags.removeWhere((tag) => tag.id == event.id);
      emit(state.copyWith(tags: List.of(updatedTags)));
    } catch (e) {
      emit(state.copyWith(status: ManageTagStatus.error));
    }
  }

  void _onManageTagRename(
      ManageTagRename event, Emitter<ManageTagState> emit) async {
    try {
      final tag =
          await tagRepository.renameTag(id: event.id, name: event.newName);
      final updatedIndex = state.tags.indexWhere((tag) {
        return tag.id == event.id;
      });

      final List<Tag> updatedTags = state.tags;
      updatedTags[updatedIndex] = tag;
      emit(state.copyWith(tags: List.of(updatedTags)));
    } catch (e) {
      emit(state.copyWith(status: ManageTagStatus.error));
    }
  }
}
