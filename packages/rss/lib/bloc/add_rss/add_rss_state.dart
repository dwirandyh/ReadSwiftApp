part of 'add_rss_bloc.dart';

abstract class AddRssState extends Equatable {
  const AddRssState();
}

class AddRssInitial extends AddRssState {
  @override
  List<Object> get props => [];
}

class AddRssLoading extends AddRssState {
  @override
  List<Object?> get props => [];
}

class AddRssFailed extends AddRssState {
  final String error;

  const AddRssFailed({required this.error});

  @override
  List<Object?> get props => [error];
}

class AddRssSuccess extends AddRssState {
  @override
  List<Object?> get props => [];
}
