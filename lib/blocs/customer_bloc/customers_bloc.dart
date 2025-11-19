import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sfm_logistic/services/customer_list_service.dart';

part 'customers_event.dart';
part 'customers_state.dart';

class CustomersBloc extends Bloc<CustomersEvent, CustomersState> {
  final CustomerListService service;
  CustomersBloc({required this.service}) : super(CustomersLoading()) {
    on<LoadCustomerList>((event, emit) async {
      try {
        await service.getCustomers();
        emit(CustomersLoaded());
      } catch (e) {
        emit(CustomersLoadFailed(failure: e));
      }
    });
  }
}
