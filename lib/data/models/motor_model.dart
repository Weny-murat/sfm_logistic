// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MotorModel {
  int logicalRef;
  String code;
  String name;
  String stGrpCode;
  MotorModel({
    required this.logicalRef,
    required this.code,
    required this.name,
    required this.stGrpCode,
  });

  MotorModel copyWith({
    int? logicalRef,
    String? code,
    String? name,
    String? stGrpCode,
  }) {
    return MotorModel(
      logicalRef: logicalRef ?? this.logicalRef,
      code: code ?? this.code,
      name: name ?? this.name,
      stGrpCode: stGrpCode ?? this.stGrpCode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'logicalRef': logicalRef,
      'code': code,
      'name': name,
      'stGrpCode': stGrpCode,
    };
  }

  factory MotorModel.fromMap(Map<String, dynamic> map) {
    return MotorModel(
      logicalRef: map['logicalRef'] as int,
      code: map['code'] as String,
      name: map['name'] as String,
      stGrpCode: map['stGrpCode'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MotorModel.fromJson(String source) =>
      MotorModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MotorModel(logicalRef: $logicalRef, code: $code, name: $name, stGrpCode: $stGrpCode)';
  }

  @override
  bool operator ==(covariant MotorModel other) {
    if (identical(this, other)) return true;

    return other.logicalRef == logicalRef &&
        other.code == code &&
        other.name == name &&
        other.stGrpCode == stGrpCode;
  }

  @override
  int get hashCode {
    return logicalRef.hashCode ^
        code.hashCode ^
        name.hashCode ^
        stGrpCode.hashCode;
  }
}
