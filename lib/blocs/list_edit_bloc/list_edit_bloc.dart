import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sfm_logistic/blocs/list_edit_bloc/list_edit_event.dart';
import 'package:sfm_logistic/blocs/list_edit_bloc/list_edit_state.dart';
import 'package:sfm_logistic/blocs/loading_list_cubit/loading_list_cubit.dart';
import 'package:sfm_logistic/core/app_consts.dart';
import 'package:sfm_logistic/services/customer_list_service.dart';

class ListEditBloc extends Bloc<ListEditEvent, ListEditState> {
  final CustomerListService customerListService;
  final LoadingListCubit loadingListCubit;
  final GoRouter router;
  ListEditBloc({
    required this.router,
    required this.customerListService,
    required this.loadingListCubit,
  }) : super(ListEditIdle()) {
    on<ListEditStarted>((event, emit) {
      AppConstants.loadingForm.updateValue({
        'customer': customerListService.getCustomerById(event.list.firmaId),
        'date': event.list.tarih,
        'plate': event.list.aracPlaka,
        'note': event.list.not,
        'deliverer': event.list.teslimEden,
        'receiver': event.list.teslimAlan,
        'isCustom': event.list.isCustom,
        'name': event.list.isCustom == true ? event.list.name : null,
        'tel': event.list.isCustom == true ? event.list.tel : null,
        'tc': event.list.isCustom == true ? event.list.tc : null,
      });
      loadingListCubit.addAll(event.list.yuklenenAraclar);
      router.go('/l_list');
      emit(ListEditing(list: event.list));
    });
    on<ListEditFinished>((event, emit) {
      emit(ListEditIdle());
    });
  }
}
