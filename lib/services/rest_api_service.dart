import 'dart:developer';

import 'package:sfm_logistic/data/models/chassis_info.dart';
import 'package:sfm_logistic/data/models/customer_list_response.dart';
import 'package:sfm_logistic/data/models/data_result.dart';
import 'package:sfm_logistic/data/models/loading_list.dart';
import 'package:sfm_logistic/data/network_service.dart';

class RestApiService {
  final NetworkService network;

  RestApiService(this.network);

  Future<DataResult<CustomerListResponse>> getCustomers() {
    return network.get(
      '/api/Customers',
      parser: (json) => CustomerListResponse.fromJson(json),
    );
  }

  Future<DataResult<ChassisInfo>> checkChassis(
    String chassisId,
    String motorId,
  ) {
    return network.get(
      '/api/ChassisCheck/$chassisId',
      parser: (json) => ChassisInfo.fromMap(json),
    );
  }

  Future<DataResult> saveLoadingList(Map<String, dynamic> formValues) {
    log(formValues.toString());
    return network.post('/api/LoadingList', body: formValues);
  }

  Future<DataResult> deleteLoadingList(int id) {
    return network.delete('/api/LoadingList/$id');
  }

  Future<DataResult> archiveLoadingList(LoadingList list) {
    final newList = list.copyWith(frozen: true).toMap();
    log(newList.toString());
    return network.put('/api/LoadingList/${list.id}', body: newList);
  }

  Future<DataResult> unArchiveLoadingList(LoadingList list) {
    final newList = list.copyWith(frozen: false).toMap();
    log(newList.toString());
    return network.put('/api/LoadingList/${list.id}', body: newList);
  }

  Future<DataResult> updateLoadingList(
    int id,
    Map<String, dynamic> formValues,
  ) {
    return network.put('/api/LoadingList/$id', body: formValues);
  }
}
