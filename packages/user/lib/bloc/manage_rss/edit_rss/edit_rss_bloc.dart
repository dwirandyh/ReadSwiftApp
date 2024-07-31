import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rss_api/rss_api.dart';

part 'edit_rss_event.dart';
part 'edit_rss_state.dart';

class EditRssBloc extends Bloc<EditRssEvent, EditRssState> {
  final RssRepositoryApi repository;
  final RssFeed rssFeed;

  EditRssBloc({required this.repository, required this.rssFeed})
      : super(EditRssInitial()) {
    on<EditRssRequested>(_onEditRssRequested);
  }

  void _onEditRssRequested(
      EditRssRequested event, Emitter<EditRssState> emit) async {
    try {
      emit(EditRssLoading());
      await repository.editRss(
          id: rssFeed.id, name: event.name, url: event.url);
      emit(EditRssSuccess());
    } catch (_) {
      emit(
          EditRssFailed(error: "Failed to edit rss, please check the RSS URL"));
    }
  }
}
