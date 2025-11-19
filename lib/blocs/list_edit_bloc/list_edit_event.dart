import 'package:sfm_logistic/data/models/loading_list.dart';

sealed class ListEditEvent {}

class ListEditFinished extends ListEditEvent {}

class ListEditStarted extends ListEditEvent {
  final LoadingList list;

  ListEditStarted({required this.list});
}
