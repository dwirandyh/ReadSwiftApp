part of 'add_rss_bloc.dart';

abstract class AddRssEvent extends Equatable {
  const AddRssEvent();
}

class AddRssRequested extends AddRssEvent {
  final String? name;
  final String url;

  const AddRssRequested({this.name, required this.url});

  @override
  List<Object?> get props => [name, url];
}
