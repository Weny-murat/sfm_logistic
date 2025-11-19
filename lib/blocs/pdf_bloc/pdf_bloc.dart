import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sfm_logistic/data/models/customer.dart';
import 'package:sfm_logistic/data/models/loading_list.dart';
import 'package:sfm_logistic/services/pdf_service.dart';

part 'pdf_event.dart';
part 'pdf_state.dart';

class PdfBloc extends Bloc<PdfEvent, PdfState> {
  final PdfService pdfService;
  PdfBloc({required this.pdfService}) : super(PdfInitial()) {
    on<CreatePdf>((event, emit) async {
      final data = await pdfService.generatePdf(
        loadingList: event.list,
        customer: event.customer,
      );
      emit(PdfCreated(data: data));
    });
  }
}
