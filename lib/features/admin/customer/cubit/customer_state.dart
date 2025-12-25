part of 'customer_cubit.dart';

@immutable
sealed class CustomerState {}

final class CustomerInitial extends CustomerState {}

final class GetCustomersLoading extends CustomerState {}

final class GetCustomersSuccess extends CustomerState {
  final List<CustomerModel> customers;
  GetCustomersSuccess(this.customers);
}

final class GetCustomersError extends CustomerState {
  final String error;
  GetCustomersError(this.error);
}

final class GetCustomerByIdLoading extends CustomerState {}

final class GetCustomerByIdSuccess extends CustomerState {
  final CustomerModel customer;
  GetCustomerByIdSuccess(this.customer);
}

final class GetCustomerByIdError extends CustomerState {
  final String error;
  GetCustomerByIdError(this.error);
}

final class CreateCustomerLoading extends CustomerState {}

final class CreateCustomerSuccess extends CustomerState {
  final String message;
  CreateCustomerSuccess(this.message);
}

final class CreateCustomerError extends CustomerState {
  final String error;
  CreateCustomerError(this.error);
}

final class UpdateCustomerLoading extends CustomerState {}

final class UpdateCustomerSuccess extends CustomerState {
  final String message;
  UpdateCustomerSuccess(this.message);
}

final class UpdateCustomerError extends CustomerState {
  final String error;
  UpdateCustomerError(this.error);
}

final class DeleteCustomerLoading extends CustomerState {}

final class DeleteCustomerSuccess extends CustomerState {
  final String message;
  DeleteCustomerSuccess(this.message);
}

final class DeleteCustomerError extends CustomerState {
  final String error;
  DeleteCustomerError(this.error);
}

final class UpdateCustomerPointsLoading extends CustomerState {}

final class UpdateCustomerPointsSuccess extends CustomerState {
  final String message;
  final int newPoints;
  UpdateCustomerPointsSuccess(this.message, this.newPoints);
}

final class UpdateCustomerPointsError extends CustomerState {
  final String error;
  UpdateCustomerPointsError(this.error);
}

final class UpdateCustomerDueLoading extends CustomerState {}

final class UpdateCustomerDueSuccess extends CustomerState {
  final String message;
  final double newAmountDue;
  final bool newIsDueStatus;
  UpdateCustomerDueSuccess(this.message, this.newAmountDue, this.newIsDueStatus);
}

final class UpdateCustomerDueError extends CustomerState {
  final String error;
  UpdateCustomerDueError(this.error);
}