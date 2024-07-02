part of 'delete_account_bloc.dart';

@immutable
sealed class DeleteAccountState {}

final class DeleteAccountInitial extends DeleteAccountState {}

final class DeleteAccountLoading extends DeleteAccountState {}

final class DeleteAccountSuccess extends DeleteAccountState {}

final class DeleteAccountFailure extends DeleteAccountState {
  final String message;

  DeleteAccountFailure(this.message);
}
