part of 'customers_bloc.dart';

sealed class CustomersState {}

final class CustomersLoading extends CustomersState {}

final class CustomersLoaded extends CustomersState {}

final class CustomersLoadFailed extends CustomersState {
  final Object failure;

  CustomersLoadFailed({required this.failure});
}
