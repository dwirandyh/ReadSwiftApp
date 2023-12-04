part of 'bookmark_clipboard_bloc.dart';

@immutable
abstract class BookmarkClipboardEvent {}

class BookmarkClipboardLinkRequested extends BookmarkClipboardEvent {
  final String link;

  BookmarkClipboardLinkRequested({required this.link});
}

class BookmarkClipboardCloseRequested extends BookmarkClipboardEvent {}

class BookmarkClipboardSaveRequested extends BookmarkClipboardEvent {
  final String link;

  BookmarkClipboardSaveRequested({required this.link});
}
