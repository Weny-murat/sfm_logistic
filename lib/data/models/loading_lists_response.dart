// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:sfm_logistic/data/models/loading_list.dart';

class LoadingListsResponse {
  final int page;
  final int pageSize;
  final int totalCount;
  final int totalPages;
  List<LoadingList> items;
  LoadingListsResponse({
    required this.page,
    required this.pageSize,
    required this.totalCount,
    required this.totalPages,
    required this.items,
  });

  LoadingListsResponse copyWith({
    int? page,
    int? pageSize,
    int? totalCount,
    int? totalPages,
    List<LoadingList>? items,
  }) {
    return LoadingListsResponse(
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
      totalCount: totalCount ?? this.totalCount,
      totalPages: totalPages ?? this.totalPages,
      items: items ?? this.items,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'page': page,
      'pageSize': pageSize,
      'totalCount': totalCount,
      'totalPages': totalPages,
      'items': items.map((x) => x.toMap()).toList(),
    };
  }

  factory LoadingListsResponse.fromMap(Map<String, dynamic> map) {
    return LoadingListsResponse(
      page: map['page'] as int,
      pageSize: map['pageSize'] as int,
      totalCount: map['totalCount'] as int,
      totalPages: map['totalPages'] as int,
      items: List<LoadingList>.from(
        (map['items'] as List<dynamic>).map<LoadingList>(
          (x) => LoadingList.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory LoadingListsResponse.fromJson(String source) =>
      LoadingListsResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LoadingListsResponse(page: $page, pageSize: $pageSize, totalCount: $totalCount, totalPages: $totalPages, items: $items)';
  }

  @override
  bool operator ==(covariant LoadingListsResponse other) {
    if (identical(this, other)) return true;

    return other.page == page &&
        other.pageSize == pageSize &&
        other.totalCount == totalCount &&
        other.totalPages == totalPages &&
        listEquals(other.items, items);
  }

  @override
  int get hashCode {
    return page.hashCode ^
        pageSize.hashCode ^
        totalCount.hashCode ^
        totalPages.hashCode ^
        items.hashCode;
  }
}
