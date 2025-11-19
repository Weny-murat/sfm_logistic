// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Customer {
  final int id;
  final int sourceId;
  final String code;
  final String name;
  final String address1;
  final String address2;
  final String city;
  final String country;
  final String postCode;
  final String tel1;
  final String tel2;
  final String fax;
  final String email;
  final String web;
  final String taxOffice;
  final String taxNr;
  final String surname;
  final String cellPhone;
  Customer({
    required this.id,
    required this.sourceId,
    required this.code,
    required this.name,
    required this.address1,
    required this.address2,
    required this.city,
    required this.country,
    required this.postCode,
    required this.tel1,
    required this.tel2,
    required this.fax,
    required this.email,
    required this.web,
    required this.taxOffice,
    required this.taxNr,
    required this.surname,
    required this.cellPhone,
  });

  Customer copyWith({
    int? id,
    int? sourceId,
    String? code,
    String? name,
    String? address1,
    String? address2,
    String? city,
    String? country,
    String? postCode,
    String? tel1,
    String? tel2,
    String? fax,
    String? email,
    String? web,
    String? taxOffice,
    String? taxNr,
    String? surname,
    String? cellPhone,
  }) {
    return Customer(
      id: id ?? this.id,
      sourceId: sourceId ?? this.sourceId,
      code: code ?? this.code,
      name: name ?? this.name,
      address1: address1 ?? this.address1,
      address2: address2 ?? this.address2,
      city: city ?? this.city,
      country: country ?? this.country,
      postCode: postCode ?? this.postCode,
      tel1: tel1 ?? this.tel1,
      tel2: tel2 ?? this.tel2,
      fax: fax ?? this.fax,
      email: email ?? this.email,
      web: web ?? this.web,
      taxOffice: taxOffice ?? this.taxOffice,
      taxNr: taxNr ?? this.taxNr,
      surname: surname ?? this.surname,
      cellPhone: cellPhone ?? this.cellPhone,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'sourceId': sourceId,
      'code': code,
      'name': name,
      'address1': address1,
      'address2': address2,
      'city': city,
      'country': country,
      'postCode': postCode,
      'tel1': tel1,
      'tel2': tel2,
      'fax': fax,
      'email': email,
      'web': web,
      'taxOffice': taxOffice,
      'taxNr': taxNr,
      'surname': surname,
      'cellPhone': cellPhone,
    };
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      id: map['id'] as int,
      sourceId: map['sourceId'] as int,
      code: map['code'] as String,
      name: map['name'] as String,
      address1: map['address1'] as String,
      address2: map['address2'] as String,
      city: map['city'] as String,
      country: map['country'] as String,
      postCode: map['postCode'] as String,
      tel1: map['tel1'] as String,
      tel2: map['tel2'] as String,
      fax: map['fax'] as String,
      email: map['email'] as String,
      web: map['web'] as String,
      taxOffice: map['taxOffice'] as String,
      taxNr: map['taxNr'] as String,
      surname: map['surname'] as String,
      cellPhone: map['cellPhone'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Customer.fromJson(String source) =>
      Customer.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Customer(id: $id, sourceId: $sourceId, code: $code, name: $name, address1: $address1, address2: $address2, city: $city, country: $country, postCode: $postCode, tel1: $tel1, tel2: $tel2, fax: $fax, email: $email, web: $web, taxOffice: $taxOffice, taxNr: $taxNr, surname: $surname, cellPhone: $cellPhone)';
  }

  @override
  bool operator ==(covariant Customer other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.sourceId == sourceId &&
        other.code == code &&
        other.name == name &&
        other.address1 == address1 &&
        other.address2 == address2 &&
        other.city == city &&
        other.country == country &&
        other.postCode == postCode &&
        other.tel1 == tel1 &&
        other.tel2 == tel2 &&
        other.fax == fax &&
        other.email == email &&
        other.web == web &&
        other.taxOffice == taxOffice &&
        other.taxNr == taxNr &&
        other.surname == surname &&
        other.cellPhone == cellPhone;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        sourceId.hashCode ^
        code.hashCode ^
        name.hashCode ^
        address1.hashCode ^
        address2.hashCode ^
        city.hashCode ^
        country.hashCode ^
        postCode.hashCode ^
        tel1.hashCode ^
        tel2.hashCode ^
        fax.hashCode ^
        email.hashCode ^
        web.hashCode ^
        taxOffice.hashCode ^
        taxNr.hashCode ^
        surname.hashCode ^
        cellPhone.hashCode;
  }
}
