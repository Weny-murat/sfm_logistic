import 'package:sfm_logistic/data/models/customer.dart';

class CustomerListResponse {
  List<Customer> customers;

  CustomerListResponse({required this.customers});

  factory CustomerListResponse.fromJson(json) {
    final newList = List<Map<String, dynamic>>.from(json as List);
    return CustomerListResponse(
      customers: newList.map((item) => Customer.fromMap(item)).toList(),
    );
  }
}
