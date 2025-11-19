part of 'pdf_bloc.dart';

sealed class PdfState {}

final class PdfInitial extends PdfState {}

final class PdfCreating extends PdfState {}

final class PdfCreated extends PdfState {
  final PdfData data;

  PdfCreated({required this.data});
}

final class PdfCreationFailed extends PdfState {
  final Object error;

  PdfCreationFailed({required this.error});
}
