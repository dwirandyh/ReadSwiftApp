import 'package:equatable/equatable.dart';

class Tag extends Equatable {
  final int id;
  final String name;

  const Tag({
    required this.id,
    required this.name,
  });

  static Tag all() {
    return const Tag(id: -1, name: "All");
  }

  Tag copyWith({
    int? id,
    String? name,
  }) {
    return Tag(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  List<Object?> get props => [id, name];
}
