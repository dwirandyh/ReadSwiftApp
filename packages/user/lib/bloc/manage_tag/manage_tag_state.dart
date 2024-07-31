part of 'manage_tag_bloc.dart';

enum ManageTagStatus { loading, loaded, error }

final class ManageTagState {
  final ManageTagStatus status;
  final List<Tag> tags;

  ManageTagState({required this.status, required this.tags});

  factory ManageTagState.initial() {
    return ManageTagState(status: ManageTagStatus.loading, tags: []);
  }

  ManageTagState copyWith({ManageTagStatus? status, List<Tag>? tags}) {
    return ManageTagState(
      status: status ?? this.status,
      tags: tags ?? this.tags,
    );
  }
}
