import 'package:equatable/equatable.dart';

class RssFeed extends Equatable {
  final int id;
  final String url;
  final String name;

  const RssFeed({required this.id, required this.url, required this.name});

  @override
  List<Object?> get props => [id, url, name];
}
