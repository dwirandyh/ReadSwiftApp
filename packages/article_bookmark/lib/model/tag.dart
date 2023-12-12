import 'package:equatable/equatable.dart';

class Tag extends Equatable {
  final int id;
  final String name;

  Tag({
    required this.id,
    required this.name,
  });

  static Tag all() {
    return Tag(id: -1, name: "All");
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
  // TODO: implement props
  List<Object?> get props => [id, name];
}
