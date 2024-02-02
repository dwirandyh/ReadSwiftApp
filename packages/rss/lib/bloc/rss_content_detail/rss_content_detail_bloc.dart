import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rss/model/rss_content.dart';
import 'package:rss/repository/rss_content_repository.dart';

part 'rss_content_detail_event.dart';
part 'rss_content_detail_state.dart';

class RssContentDetailBloc
    extends Bloc<RssContentDetailEvent, RssContentDetailState> {
  factory RssContentDetailBloc.create(int contentId) {
    return RssContentDetailBloc(
      rssContentRepository: RssContentRepositoryImpl.create(),
      contentId: contentId,
    );
  }

  final RssContentRepository rssContentRepository;
  final int contentId;

  RssContentDetailBloc({
    required this.rssContentRepository,
    required this.contentId,
  }) : super(RssContentDetailLoading()) {
    on<RssContentDetailFetched>(_onRssContentDetailFetched);
  }

  Future<void> _onRssContentDetailFetched(RssContentDetailFetched event,
      Emitter<RssContentDetailState> emit) async {
    try {
      emit(RssContentDetailLoading());

      final RssContent content =
          await rssContentRepository.fetchRssContentDetail(id: contentId);
      emit(RssContentDetailSuccess(content: content));
    } catch (_) {
      emit(RssContentDetailFailed());
    }
  }
}
