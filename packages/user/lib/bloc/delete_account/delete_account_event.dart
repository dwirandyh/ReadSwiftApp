part of 'delete_account_bloc.dart';

@immutable
sealed class DeleteAccountEvent {}

final class DeleteAccountRequested extends DeleteAccountEvent {}
