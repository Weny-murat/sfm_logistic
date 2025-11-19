import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sfm_logistic/data/models/loading_row.dart';

class LoadingListCubit extends Cubit<List<LoadingRow>> {
  LoadingListCubit() : super(<LoadingRow>[]);

  void add(LoadingRow newChassis) => emit([...state, newChassis]);

  void addAll(List<LoadingRow> chassisList) => emit(chassisList);

  void remove(String chassis) {
    emit(state.where((value) => value.sasiNo != chassis).toList());
  }

  void removeAll() => emit(<LoadingRow>[]);

  
}
