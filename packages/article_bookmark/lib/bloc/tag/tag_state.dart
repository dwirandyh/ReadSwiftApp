part of 'tag_bloc.dart';

enum TagStatus { initial, success, error }

class TagState extends Equatable {
  final List<Tag> tags;
  final Tag selectedTag;
  final TagStatus status;

  const TagState({
    this.tags = const [],
    required this.selectedTag,
    this.status = TagStatus.initial,
  });

  TagState copyWith({
    List<Tag>? tags,
    Tag? selectedTag,
    TagStatus? status,
  }) {
    return TagState(
      tags: tags ?? this.tags,
      selectedTag: selectedTag ?? this.selectedTag,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [tags, selectedTag, status];
}
