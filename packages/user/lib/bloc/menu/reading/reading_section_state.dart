part of 'reading_section_bloc.dart';

final class ReadingSectionState {
  final bool isImageDisplayEnabled;
  final bool isContinueReadingEnabled;

  factory ReadingSectionState.initial() {
    return ReadingSectionState(
      isImageDisplayEnabled: true,
      isContinueReadingEnabled: true,
    );
  }

  ReadingSectionState({
    required this.isImageDisplayEnabled,
    required this.isContinueReadingEnabled,
  });

  ReadingSectionState copyWith({
    bool? isImageDisplayEnabled,
    bool? isContinueReadingEnabled,
  }) {
    return ReadingSectionState(
      isImageDisplayEnabled:
          isImageDisplayEnabled ?? this.isImageDisplayEnabled,
      isContinueReadingEnabled:
          isContinueReadingEnabled ?? this.isContinueReadingEnabled,
    );
  }
}
