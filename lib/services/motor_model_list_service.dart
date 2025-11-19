import 'dart:developer';
import 'package:sfm_logistic/data/models/data_result.dart';
import 'package:sfm_logistic/data/models/motor_model.dart';
import 'package:sfm_logistic/data/models/motor_model_list_response.dart';
import 'package:sfm_logistic/data/network_service.dart';

class MotorModelListService {
  // --- Singleton Tanımı ---
  static MotorModelListService? _instance;
  final NetworkService network;
  List<MotorModel> models = [];

  factory MotorModelListService(NetworkService networkService) {
    _instance ??= MotorModelListService._internal(networkService);
    return _instance!;
  }

  MotorModelListService._internal(this.network);

  static MotorModelListService get instance {
    if (_instance == null) {
      throw Exception(
        'MotorModelListService henüz başlatılmadı. '
        'Önce MotorModelListService(NetworkService) ile başlat.',
      );
    }
    return _instance!;
  }

  String getModelById(int id) {
    return models.firstWhere((element) => element.logicalRef == id).name;
  }

  Future<List<MotorModel>> getModels() async {
    final result = await network.get(
      '/api/ModelModels',
      parser: (json) {
        return MotorModelListResponse.fromJson(json);
      },
    );

    switch (result) {
      case Success<MotorModelListResponse>():
        models = result.data.models;
        return result.data.models;
      case Failure<MotorModelListResponse>():
        log(result.message);
        return [];
    }
  }
}
