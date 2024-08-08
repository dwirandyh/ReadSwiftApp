import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:user_api/user_api.dart';

part 'reading_section_event.dart';
part 'reading_section_state.dart';

class ReadingSectionBloc
    extends Bloc<ReadingSectionEvent, ReadingSectionState> {
  final UserSettingRepositoryApi userSettingRepository;

  ReadingSectionBloc({required this.userSettingRepository})
      : super(ReadingSectionState.initial()) {
    on<ReadingSectionSettingRequested>(_onReadingSectionSettingRequested);
    on<ReadingSectionImageDisplayChanged>(_onReadingSectionImageDisplayChanged);
    on<ReadingSectionContinueReadingChanged>(
        _onReadingSectionContinueReadingChanged);
  }

  void _onReadingSectionSettingRequested(ReadingSectionSettingRequested event,
      Emitter<ReadingSectionState> emit) async {
    try {
      final isImageDisplayEnabled =
          userSettingRepository.getImageDisplayOptions();
      final isContinueReadingEnabled =
          userSettingRepository.getContinueReading();

      emit(ReadingSectionState(
        isImageDisplayEnabled: isImageDisplayEnabled,
        isContinueReadingEnabled: isContinueReadingEnabled,
      ));
    } catch (e) {
      emit(ReadingSectionState.initial());
    }
  }

  void _onReadingSectionImageDisplayChanged(
      ReadingSectionImageDisplayChanged event,
      Emitter<ReadingSectionState> emit) async {
    try {
      await userSettingRepository.setImageDisplayOptions(
          isEnabled: event.isEnabled);
    } finally {
      emit(state.copyWith(isImageDisplayEnabled: event.isEnabled));
    }
  }

  void _onReadingSectionContinueReadingChanged(
      ReadingSectionContinueReadingChanged event,
      Emitter<ReadingSectionState> emit) async {
    try {
      await userSettingRepository.setContinueReading(
          isEnabled: event.isEnabled);
    } finally {
      emit(state.copyWith(isContinueReadingEnabled: event.isEnabled));
    }
  }
}
