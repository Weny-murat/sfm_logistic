part of 'pdf_bloc.dart';

sealed class PdfEvent {}

class CreatePdf extends PdfEvent {
  final LoadingList list;
  final Customer? customer;

  CreatePdf({required this.list, required this.customer});
}
