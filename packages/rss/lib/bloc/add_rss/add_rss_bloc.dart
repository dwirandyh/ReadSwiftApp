import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rss/repository/rss_repository.dart';

part 'add_rss_event.dart';
part 'add_rss_state.dart';

class AddRssBloc extends Bloc<AddRssEvent, AddRssState> {
  final RssRepository rssRepository;

  AddRssBloc({required this.rssRepository}) : super(AddRssInitial()) {
    on<AddRssRequested>(_onAddRssRequested);
  }

  Future<void> _onAddRssRequested(
      AddRssRequested event, Emitter<AddRssState> emit) async {
    try {
      emit(AddRssLoading());
      await rssRepository.addRssFeed(name: event.name, url: event.url);
      emit(AddRssSuccess());
    } catch (_) {
      emit(const AddRssFailed(
          error: 'Failed to add new RSS, please check the RSS URL'));
    }
  }
}
