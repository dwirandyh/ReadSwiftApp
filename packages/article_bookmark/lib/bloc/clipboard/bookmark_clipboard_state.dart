part of 'bookmark_clipboard_bloc.dart';

@immutable
abstract class BookmarkClipboardState {}

class BookmarkClipboardClosed extends BookmarkClipboardState {}

class BookmarkClipboardSaved extends BookmarkClipboardState {}

class BookmarkClipboardFailed extends BookmarkClipboardState {}

class BookmarkClipboardLinkUpdated extends BookmarkClipboardState {
  final String url;
  BookmarkClipboardLinkUpdated({required this.url});
}