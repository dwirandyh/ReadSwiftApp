part of 'bookmark_clipboard_bloc.dart';

@immutable
sealed class BookmarkClipboardEvent extends Equatable {}

class BookmarkClipboardLinkRequested extends BookmarkClipboardEvent {
  final String link;

  BookmarkClipboardLinkRequested({required this.link});

  @override
  List<Object?> get props => [link];
}

class BookmarkClipboardCloseRequested extends BookmarkClipboardEvent {
  @override
  List<Object?> get props => [];
}

class BookmarkClipboardSaveRequested extends BookmarkClipboardEvent {
  final String link;

  BookmarkClipboardSaveRequested({required this.link});

  @override
  List<Object?> get props => [link];
}
