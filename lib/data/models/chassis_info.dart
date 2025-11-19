// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import 'package:sfm_logistic/data/models/loading_row.dart';
import 'package:sfm_logistic/data/models/motor_transaction.dart';

class ChassisInfo {
  LoadingRow rowInfo;
  List<MotorTransaction> transactions;
  ChassisInfo({required this.rowInfo, required this.transactions});

  ChassisInfo copyWith({
    LoadingRow? rowInfo,
    List<MotorTransaction>? transactions,
  }) {
    return ChassisInfo(
      rowInfo: rowInfo ?? this.rowInfo,
      transactions: transactions ?? this.transactions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'rowInfo': rowInfo.toMap(),
      'transactions': transactions.map((x) => x.toMap()).toList(),
    };
  }

  factory ChassisInfo.fromMap(Map<String, dynamic> map) {
    return ChassisInfo(
      rowInfo: LoadingRow(
        sasiNo: map['serial'],
        motorNo: map['itemName'],
        modelReferansNo: map['itemRef'].toString(),
      ),
      transactions: List<MotorTransaction>.from(
        (map['transactions'] as List<dynamic>).map<MotorTransaction>(
          (x) => MotorTransaction.fromMap(x as Map<String, dynamic>),
        ),
      ).sortedBy((element) => element.datE_),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChassisInfo.fromJson(String source) =>
      ChassisInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ChassisInfo(rowInfo: $rowInfo, transactions: $transactions)';

  @override
  bool operator ==(covariant ChassisInfo other) {
    if (identical(this, other)) return true;

    return other.rowInfo == rowInfo &&
        listEquals(other.transactions, transactions);
  }

  @override
  int get hashCode => rowInfo.hashCode ^ transactions.hashCode;
}
