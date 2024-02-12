import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rss/repository/rss_content_repository.dart';

part 'rss_content_bookmark_event.dart';
part 'rss_content_bookmark_state.dart';

class RssContentBookmarkBloc
    extends Bloc<RssContentBookmarkEvent, RssContentBookmarkState> {
  final RssContentRepository rssContentRepository;

  RssContentBookmarkBloc({required this.rssContentRepository})
      : super(RssContentBookmarkInitial()) {
    on<RssContentBookmarkAdded>(_onRssContentBookmarkAdded);
  }

  factory RssContentBookmarkBloc.create() {
    return RssContentBookmarkBloc(
        rssContentRepository: RssContentRepositoryImpl.create());
  }

  Future<void> _onRssContentBookmarkAdded(
    RssContentBookmarkAdded event,
    Emitter<RssContentBookmarkState> emit,
  ) async {
    try {
      await rssContentRepository.addToBookmark(id: event.contentId);
      emit(const RssContentBookmarkAddSuccess(
          message: "RSS feed added to bookmarks successfully."));
    } catch (_) {
      emit(const RssContentBookmarkAddFailed(
          message:
              "Couldn't add content to your bookmark. Try again later, please!"));
    }
  }
}
