import 'package:collection/collection.dart';
import 'package:sfm_logistic/data/models/customer.dart';
import 'package:sfm_logistic/data/models/customer_list_response.dart';
import 'package:sfm_logistic/data/models/data_result.dart';
import 'package:sfm_logistic/data/network_service.dart';

class CustomerListService {
  List<Customer> customers = [];
  NetworkService networkService;
  CustomerListService({required this.networkService});

  Future<DataResult> getCustomers() async {
    final result = await networkService.get(
      '/api/Customers',
      parser: (json) {
        return CustomerListResponse.fromJson(json);
      },
    );

    switch (result) {
      case Success<CustomerListResponse>():
        customers = result.data.customers;
        return result;
      case Failure<CustomerListResponse>():
        customers = [];
        return result;
    }
  }

  Customer? getCustomerById(int id) {
    return customers.firstWhereOrNull((element) => element.sourceId == id);
  }
}
