import 'package:sfm_logistic/data/models/motor_model.dart';

class MotorModelListResponse {
  List<MotorModel> models;

  MotorModelListResponse({required this.models});

  factory MotorModelListResponse.fromJson(json) {
    final newList = List<Map<String, dynamic>>.from(json as List);
    return MotorModelListResponse(
      models: newList.map((item) => MotorModel.fromMap(item)).toList(),
    );
  }
}
