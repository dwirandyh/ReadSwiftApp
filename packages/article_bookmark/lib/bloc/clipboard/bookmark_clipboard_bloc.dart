import 'package:article_bookmark/repository/article_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'bookmark_clipboard_event.dart';
part 'bookmark_clipboard_state.dart';

class BookmarkClipboardBloc
    extends Bloc<BookmarkClipboardEvent, BookmarkClipboardState> {
  final ArticleRepository articleRepository;

  BookmarkClipboardBloc({required this.articleRepository})
      : super(BookmarkClipboardClosed()) {
    on<BookmarkClipboardLinkRequested>(_onBookmarkClipboardLinkUpdated);
    on<BookmarkClipboardCloseRequested>(_onBookmarkClipboardCloseRequested);
    on<BookmarkClipboardSaveRequested>(_onBookmarkClipboardSaveRequested);
  }

  void _onBookmarkClipboardLinkUpdated(BookmarkClipboardLinkRequested event,
      Emitter<BookmarkClipboardState> emit) {
    emit(BookmarkClipboardLinkUpdated(url: event.link));
  }

  void _onBookmarkClipboardCloseRequested(BookmarkClipboardCloseRequested event,
      Emitter<BookmarkClipboardState> emit) {
    emit(BookmarkClipboardClosed());
  }

  Future<void> _onBookmarkClipboardSaveRequested(
      BookmarkClipboardSaveRequested event,
      Emitter<BookmarkClipboardState> emit) async {
    try {
      await articleRepository.saveToBookmark(url: event.link);
      emit(BookmarkClipboardSaved());
    } catch (error) {
      emit(BookmarkClipboardFailed());
    }
  }
}
