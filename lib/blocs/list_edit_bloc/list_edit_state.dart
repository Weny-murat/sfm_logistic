import 'package:sfm_logistic/data/models/loading_list.dart';

sealed class ListEditState {}

final class ListEditIdle extends ListEditState {}

final class ListEditing extends ListEditState {
  final LoadingList list;

  ListEditing({required this.list});
}

final class ListEditSuccess extends ListEditState {}

final class ListEditFailed extends ListEditState {}
