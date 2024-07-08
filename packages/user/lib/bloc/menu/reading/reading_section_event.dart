part of 'reading_section_bloc.dart';

@immutable
sealed class ReadingSectionEvent {}

final class ReadingSectionSettingRequested extends ReadingSectionEvent {}

final class ReadingSectionImageDisplayChanged extends ReadingSectionEvent {
  final bool isEnabled;

  ReadingSectionImageDisplayChanged({required this.isEnabled});
}

final class ReadingSectionContinueReadingChanged extends ReadingSectionEvent {
  final bool isEnabled;

  ReadingSectionContinueReadingChanged({required this.isEnabled});
}
