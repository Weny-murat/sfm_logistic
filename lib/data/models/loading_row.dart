// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LoadingRow {
  final String sasiNo;
  final String motorNo;
  final String modelReferansNo;
  LoadingRow({
    required this.sasiNo,
    required this.motorNo,
    required this.modelReferansNo,
  });

  LoadingRow copyWith({
    String? sasiNo,
    String? motorNo,
    String? modelReferansNo,
  }) {
    return LoadingRow(
      sasiNo: sasiNo ?? this.sasiNo,
      motorNo: motorNo ?? this.motorNo,
      modelReferansNo: modelReferansNo ?? this.modelReferansNo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sasiNo': sasiNo,
      'motorNo': motorNo,
      'modelReferansNo': modelReferansNo,
    };
  }

  factory LoadingRow.fromMap(Map<String, dynamic> map) {
    return LoadingRow(
      sasiNo: map['sasiNo'] as String,
      motorNo: map['motorNo'] as String,
      modelReferansNo: map['modelReferansNo'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoadingRow.fromJson(String source) =>
      LoadingRow.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'LoadingRow(sasiNo: $sasiNo, motorNo: $motorNo, modelReferansNo: $modelReferansNo)';

  @override
  bool operator ==(covariant LoadingRow other) {
    if (identical(this, other)) return true;

    return other.sasiNo == sasiNo &&
        other.motorNo == motorNo &&
        other.modelReferansNo == modelReferansNo;
  }

  @override
  int get hashCode =>
      sasiNo.hashCode ^ motorNo.hashCode ^ modelReferansNo.hashCode;
}
