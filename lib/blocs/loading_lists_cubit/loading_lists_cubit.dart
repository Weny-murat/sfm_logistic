import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sfm_logistic/data/models/data_result.dart';
import 'package:sfm_logistic/data/models/loading_list.dart';
import 'package:sfm_logistic/data/models/loading_lists_response.dart';
import 'package:sfm_logistic/data/network_service.dart';

class LoadingListsCubit extends Cubit<List<LoadingList>> {
  final NetworkService network;
  LoadingListsCubit({required this.network}) : super(<LoadingList>[]);

  void add(LoadingList newList) => emit([...state, newList]);

  void addAll(List<LoadingList> lists) => emit(lists);

  void remove(int id) {
    emit(state.where((value) => value.id != id).toList());
  }

  void removeAll() => emit(<LoadingList>[]);

  Future<DataResult> getList(int id) async {
    return await network.get(
      '/api/LoadingList/$id',
      parser: (json) {
        return LoadingList.fromJson(json);
      },
    );
  }

  Future<DataResult> fetchLists() async {
    final result = await network.get(
      '/api/LoadingList/active',
      parser: (json) {
        return LoadingListsResponse.fromMap(json);
      },
    );
    switch (result) {
      case Success<LoadingListsResponse>():
        emit(result.data.items);
      case Failure<LoadingListsResponse>():
    }
    return result;
  }
}
