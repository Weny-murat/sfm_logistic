// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:sfm_logistic/data/models/loading_row.dart';

class LoadingList {
  final int id;
  final int firmaId;
  final DateTime tarih;
  final String teslimEden;
  final String? teslimAlan;
  final String? not;
  final String aracPlaka;
  final bool? isCustom;
  final String? name;
  final String? tc;
  final String? tel;
  final bool? frozen;
  final List<LoadingRow> yuklenenAraclar;
  LoadingList({
    required this.id,
    required this.firmaId,
    required this.tarih,
    required this.teslimEden,
    required this.teslimAlan,
    required this.not,
    required this.aracPlaka,
    this.isCustom,
    this.name,
    this.tc,
    this.tel,
    this.frozen,
    required this.yuklenenAraclar,
  });

  LoadingList copyWith({
    int? id,
    int? firmaId,
    DateTime? tarih,
    String? teslimEden,
    String? teslimAlan,
    String? not,
    String? aracPlaka,
    bool? isCustom,
    String? name,
    String? tc,
    String? tel,
    bool? frozen,
    List<LoadingRow>? yuklenenAraclar,
  }) {
    return LoadingList(
      id: id ?? this.id,
      firmaId: firmaId ?? this.firmaId,
      tarih: tarih ?? this.tarih,
      teslimEden: teslimEden ?? this.teslimEden,
      teslimAlan: teslimAlan ?? this.teslimAlan,
      not: not ?? this.not,
      aracPlaka: aracPlaka ?? this.aracPlaka,
      isCustom: isCustom ?? this.isCustom,
      name: name ?? this.name,
      tc: tc ?? this.tc,
      tel: tel ?? this.tel,
      frozen: frozen ?? this.frozen,
      yuklenenAraclar: yuklenenAraclar ?? this.yuklenenAraclar,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'firmaId': firmaId,
      'tarih': tarih,
      'teslimEden': teslimEden,
      'teslimAlan': teslimAlan,
      'not': not,
      'aracPlaka': aracPlaka,
      'isCustom': isCustom,
      'name': name,
      'tc': tc,
      'tel': tel,
      'frozen': frozen,
      'yuklenenAraclar': yuklenenAraclar.map((x) => x.toMap()).toList(),
    };
  }

  factory LoadingList.fromMap(Map<String, dynamic> map) {
    return LoadingList(
      id: map['id'] as int,
      firmaId: map['firmaId'] as int,
      tarih: DateTime.parse(map['tarih'] as String),
      teslimEden: map['teslimEden'] as String,
      teslimAlan: map['teslimAlan'] != null
          ? map['teslimAlan'] as String
          : null,
      not: map['not'] != null ? map['not'] as String : null,
      aracPlaka: map['aracPlaka'] as String,
      isCustom: map['isCustom'] != null ? map['isCustom'] as bool : null,
      name: map['name'] != null ? map['name'] as String : null,
      tc: map['tc'] != null ? map['tc'] as String : null,
      tel: map['tel'] != null ? map['tel'] as String : null,
      frozen: map['frozen'] != null ? map['frozen'] as bool : null,
      yuklenenAraclar: List<LoadingRow>.from(
        (map['yuklenenAraclar'] as List<dynamic>).map<LoadingRow>(
          (x) => LoadingRow.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory LoadingList.fromJson(String source) =>
      LoadingList.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LoadingList(id: $id, firmaId: $firmaId, tarih: $tarih, teslimEden: $teslimEden, teslimAlan: $teslimAlan, not: $not, aracPlaka: $aracPlaka, isCustom: $isCustom, name: $name, tc: $tc, tel: $tel, frozen: $frozen, yuklenenAraclar: $yuklenenAraclar)';
  }

  @override
  bool operator ==(covariant LoadingList other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.firmaId == firmaId &&
        other.tarih == tarih &&
        other.teslimEden == teslimEden &&
        other.teslimAlan == teslimAlan &&
        other.not == not &&
        other.aracPlaka == aracPlaka &&
        other.isCustom == isCustom &&
        other.name == name &&
        other.tc == tc &&
        other.tel == tel &&
        other.frozen == frozen &&
        listEquals(other.yuklenenAraclar, yuklenenAraclar);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        firmaId.hashCode ^
        tarih.hashCode ^
        teslimEden.hashCode ^
        teslimAlan.hashCode ^
        not.hashCode ^
        aracPlaka.hashCode ^
        isCustom.hashCode ^
        name.hashCode ^
        tc.hashCode ^
        tel.hashCode ^
        frozen.hashCode ^
        yuklenenAraclar.hashCode;
  }
}
